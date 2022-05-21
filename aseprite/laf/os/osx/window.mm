// LAF OS Library
// Copyright (C) 2019-2021  Igara Studio S.A.
// Copyright (C) 2012-2017  David Capello
//
// This file is released under the terms of the MIT license.
// Read LICENSE.txt for more information.

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "os/osx/window.h"

#include "base/debug.h"
#include "os/event.h"
#include "os/osx/event_queue.h"
#include "os/osx/view.h"
#include "os/osx/window_delegate.h"
#include "os/surface.h"
#include "os/window_spec.h"

@implementation WindowOSXObjc

- (WindowOSXObjc*)initWithImpl:(os::WindowOSX*)impl
                          spec:(const os::WindowSpec*)spec
{
  m_impl = impl;
  m_scale = spec->scale();

  NSScreen* nsScreen;
  if (spec->screen())
    nsScreen = (__bridge NSScreen*)spec->screen()->nativeHandle();
  else
    nsScreen = [NSScreen mainScreen];

  NSWindowStyleMask style = 0;
  if (spec->titled()) style |= NSWindowStyleMaskTitled;
  if (spec->closable()) style |= NSWindowStyleMaskClosable;
  if (spec->minimizable()) style |= NSWindowStyleMaskMiniaturizable;
  if (spec->resizable()) style |= NSWindowStyleMaskResizable;
  if (spec->borderless()) style |= NSWindowStyleMaskBorderless;

  NSRect contentRect;
  if (!spec->contentRect().isEmpty()) {
    contentRect =
      NSMakeRect(spec->contentRect().x - nsScreen.frame.origin.x,
                 nsScreen.frame.size.height - spec->contentRect().y2() - nsScreen.frame.origin.y,
                 spec->contentRect().w,
                 spec->contentRect().h);
  }
  else if (!spec->frame().isEmpty()) {
    NSRect frameRect =
      NSMakeRect(spec->frame().x - nsScreen.frame.origin.x,
                 nsScreen.frame.size.height - spec->frame().y2() - nsScreen.frame.origin.y,
                 spec->frame().w,
                 spec->frame().h);

    contentRect =
      [NSWindow contentRectForFrameRect:frameRect
                              styleMask:style];
  }
  else {
    // TODO is there a default size for macOS apps?
    contentRect = NSMakeRect(0, 0, 400, 300);
  }

  self = [self initWithContentRect:contentRect
                         styleMask:style
                           backing:NSBackingStoreBuffered
                             defer:NO
                            screen:nsScreen];
  if (!self)
    return nil;

  m_delegate = [[WindowOSXDelegate alloc] initWithWindowImpl:impl];

  // The NSView width and height will be a multiple of scale().
  self.contentResizeIncrements = NSMakeSize(m_scale, m_scale);

  ViewOSX* view = [[ViewOSX alloc] initWithFrame:contentRect];
  m_view = view;
  [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

  // Remove shadow for borderless windows (the shadow is too dark and
  // creates a thick black border arround our windows).
  //
  // TODO add a property in WindowSpec
  if (spec->borderless())
    self.hasShadow = NO;

  // Redraw the entire window content when we resize it.
  // TODO add support to avoid redrawing the entire window
  self.preservesContentDuringLiveResize = false;

  [self setDelegate:m_delegate];
  [self setContentView:view];

  if (spec->position() == os::WindowSpec::Position::Center) {
    [self center];
  }

  if (spec->parent())
    self.parentWindow = (__bridge NSWindow*)static_cast<os::WindowOSX*>(spec->parent())->nativeHandle();

  [self makeKeyAndOrderFront:self];

  if (spec->floating()) {
    self.level = NSFloatingWindowLevel;
    self.hidesOnDeactivate = true;
  }

  // Hide the "View > Show Tab Bar" menu item
  if ([self respondsToSelector:@selector(setTabbingMode:)])
    [self setTabbingMode:NSWindowTabbingModeDisallowed];

  return self;
}

- (os::WindowOSX*)impl
{
  return m_impl;
}

- (void)removeImpl
{
  [((ViewOSX*)self.contentView) removeImpl];

  [self setDelegate:nil];
  [m_delegate removeImpl];
  m_delegate = nil;

  m_impl = nil;
}

- (int)scale
{
  return m_scale;
}

- (void)setScale:(int)scale
{
  // If the scale is the same, we don't generate a resize event.
  if (m_scale == scale)
    return;

  m_scale = scale;
  self.contentResizeIncrements = NSMakeSize(m_scale, m_scale);

  if (m_impl) {
    NSRect bounds = [[self contentView] bounds];
    m_impl->onResize(gfx::Size(bounds.size.width,
                               bounds.size.height));
  }
}

- (gfx::Size)clientSize
{
  return gfx::Size([[self contentView] frame].size.width,
                   [[self contentView] frame].size.height);
}

- (void)setMousePosition:(const gfx::Point&)position
{
  NSView* view = self.contentView;
  NSPoint pt = NSMakePoint(
    position.x*m_scale,
    view.frame.size.height - position.y*m_scale);

  pt = [view convertPoint:pt toView:view];
  pt = [view convertPoint:pt toView:nil];
  pt = [self convertBaseToScreen:pt];
  pt.y = [[self screen] frame].size.height - pt.y;

  CGPoint pos = CGPointMake(pt.x, pt.y);
  CGEventRef event = CGEventCreateMouseEvent(
    NULL, kCGEventMouseMoved, pos, kCGMouseButtonLeft);
  CGEventPost(kCGHIDEventTap, event);
  CFRelease(event);
}

- (BOOL)setNativeCursor:(os::NativeCursor)cursor
{
  NSCursor* nsCursor = nullptr;

  switch (cursor) {
    case os::NativeCursor::Arrow:
    case os::NativeCursor::Wait:
    case os::NativeCursor::Help:
    case os::NativeCursor::SizeNE:
    case os::NativeCursor::SizeNW:
    case os::NativeCursor::SizeSE:
    case os::NativeCursor::SizeSW:
      nsCursor = [NSCursor arrowCursor];
      break;
    case os::NativeCursor::Crosshair:
      nsCursor = [NSCursor crosshairCursor];
      break;
    case os::NativeCursor::IBeam:
      nsCursor = [NSCursor IBeamCursor];
      break;
    case os::NativeCursor::Link:
      nsCursor = [NSCursor pointingHandCursor];
      break;
    case os::NativeCursor::Forbidden:
      nsCursor = [NSCursor operationNotAllowedCursor];
      break;
    case os::NativeCursor::Move:
      nsCursor = [NSCursor openHandCursor];
      break;
    case os::NativeCursor::SizeNS:
      nsCursor = [NSCursor resizeUpDownCursor];
      break;
    case os::NativeCursor::SizeWE:
      nsCursor = [NSCursor resizeLeftRightCursor];
      break;
    case os::NativeCursor::SizeN:
      nsCursor = [NSCursor resizeUpCursor];
      break;
    case os::NativeCursor::SizeE:
      nsCursor = [NSCursor resizeRightCursor];
      break;
    case os::NativeCursor::SizeS:
      nsCursor = [NSCursor resizeDownCursor];
      break;
    case os::NativeCursor::SizeW:
      nsCursor = [NSCursor resizeLeftCursor];
      break;
  }

  [self.contentView setCursor:nsCursor];
  return (nsCursor ? YES: NO);
}

- (BOOL)canBecomeKeyWindow
{
  if (m_impl)
    return YES;
  else
    return NO;
}

- (void)noResponderFor:(SEL)eventSelector
{
  if (eventSelector == @selector(keyDown:)) {
    // Do nothing (avoid beep)
  }
  else {
    [super noResponderFor:eventSelector];
  }
}

@end

namespace os {

void WindowOSX::createWindow(const os::WindowSpec& spec)
{
  m_nsWindow = [[WindowOSXObjc alloc] initWithImpl:this
                                              spec:&spec];
  m_nsWindow.releasedWhenClosed = true;
}

void WindowOSX::destroyWindow()
{
  if (!m_nsWindow)
    return;

  [m_nsWindow removeImpl];
  [(ViewOSX*)m_nsWindow.contentView destroyMouseTrackingArea];

  // Select other window
  {
    auto app = [NSApplication sharedApplication];
    auto index = [app.windows indexOfObject:m_nsWindow];
    if (index+1 < app.windows.count) {
      ++index;
    }
    else {
      --index;
    }
    if (index >= 0 && index < app.windows.count)
      [[app.windows objectAtIndex:index] makeKeyWindow];
  }

  [m_nsWindow discardEventsMatchingMask:NSEventMaskAny
                            beforeEvent:nullptr];
  [m_nsWindow close];
  m_nsWindow = nil;
}

gfx::Size WindowOSX::clientSize() const
{
  return [m_nsWindow clientSize];
}

gfx::Rect WindowOSX::frame() const
{
  NSRect r = m_nsWindow.frame;
  return gfx::Rect(r.origin.x,
                   m_nsWindow.screen.frame.size.height - r.origin.y - r.size.height,
                   r.size.width, r.size.height);
}

void WindowOSX::setFrame(const gfx::Rect& bounds)
{
  [m_nsWindow setFrame:NSMakeRect(bounds.x,
                                  m_nsWindow.screen.frame.size.height - bounds.y2(),
                                  bounds.w,
                                  bounds.h)
               display:YES];
}

gfx::Rect WindowOSX::contentRect() const
{
  NSRect r = [m_nsWindow contentRectForFrameRect:m_nsWindow.frame];
  return gfx::Rect(r.origin.x,
                   m_nsWindow.screen.frame.size.height - r.origin.y - r.size.height,
                   r.size.width, r.size.height);
}

gfx::Rect WindowOSX::restoredFrame() const
{
  return m_restoredFrame;
}

void WindowOSX::activate()
{
  [m_nsWindow makeKeyWindow];
}

void WindowOSX::maximize()
{
  [m_nsWindow zoom:m_nsWindow];
}

void WindowOSX::minimize()
{
  [m_nsWindow miniaturize:m_nsWindow];
}

bool WindowOSX::isMaximized() const
{
  return [m_nsWindow isZoomed];
}

bool WindowOSX::isMinimized() const
{
  return (m_nsWindow.miniaturized ? true: false);
}

bool WindowOSX::isFullscreen() const
{
  return ((m_nsWindow.styleMask & NSWindowStyleMaskFullScreen) == NSWindowStyleMaskFullScreen);
}

void WindowOSX::setFullscreen(bool state)
{
  if (state) {
    if (!isFullscreen()) {
      // TODO this doesn't work for borderless windows
      [m_nsWindow toggleFullScreen:m_nsWindow];
    }
  }
  else {
    if (isFullscreen()) {
      [m_nsWindow toggleFullScreen:m_nsWindow];
    }
  }
}

std::string WindowOSX::title() const
{
  return [m_nsWindow.title UTF8String];
}

void WindowOSX::setTitle(const std::string& title)
{
  [m_nsWindow setTitle:[NSString stringWithUTF8String:title.c_str()]];
}

void WindowOSX::captureMouse()
{
  // TODO
}

void WindowOSX::releaseMouse()
{
  // TODO
}

void WindowOSX::setMousePosition(const gfx::Point& position)
{
  [m_nsWindow setMousePosition:position];
}

void WindowOSX::performWindowAction(const WindowAction action,
                                    const Event* event)
{
  if (action == WindowAction::Move) {
    // We cannot use the "m_nsWindow.currentEvent" event directly
    // because sometimes it's a NSEventTypeAppKitDefined instead of
    // the mouse event and the mouse location inside that event is
    // invalid. So we just use the current mouse position from
    // [NSEvent mouseLocation] to avoid this creating a new mouse
    // event.
    NSEvent* newEvent =
      [NSEvent mouseEventWithType:NSEventTypeLeftMouseDown
                         location:[m_nsWindow convertPointFromScreen:[NSEvent mouseLocation]]
                    modifierFlags:0
                        timestamp:0
                     windowNumber:m_nsWindow.windowNumber
                          context:nil
                      eventNumber:0
                       clickCount:1
                         pressure:1.0];

    [m_nsWindow performWindowDragWithEvent:newEvent];
  }
}

os::ScreenRef WindowOSX::screen() const
{
  ASSERT(m_nsWindow);
  return os::make_ref<os::ScreenOSX>(m_nsWindow.screen);
}

os::ColorSpaceRef WindowOSX::colorSpace() const
{
  if (auto defaultCS = os::instance()->windowsColorSpace())
    return defaultCS;

  ASSERT(m_nsWindow);
  return os::convert_nscolorspace_to_os_colorspace([m_nsWindow colorSpace]);
}

int WindowOSX::scale() const
{
  return [m_nsWindow scale];
}

void WindowOSX::setScale(int scale)
{
  [m_nsWindow setScale:scale];
}

bool WindowOSX::isVisible() const
{
  return m_nsWindow.isVisible;
}

void WindowOSX::setVisible(bool visible)
{
  if (visible) {
    // The main window can be changed only when the NSWindow
    // is visible (i.e. when NSWindow::canBecomeMainWindow
    // returns YES).
    if (m_nsWindow.canBecomeMainWindow)
      [m_nsWindow makeMainWindow];
  }
  else {
    [m_nsWindow setIsVisible:false];
  }
}

bool WindowOSX::setCursor(NativeCursor cursor)
{
  return ([m_nsWindow setNativeCursor:cursor] ? true: false);
}

bool WindowOSX::setCursor(const CursorRef& cursor)
{
  [m_nsWindow.contentView
      setCursor:(cursor ? (__bridge NSCursor*)cursor->nativeHandle():
                          nullptr)];
  return true;
}

void* WindowOSX::nativeHandle() const
{
  return (__bridge void*)m_nsWindow;
}

void WindowOSX::onBeforeMaximizeFrame()
{
  m_restoredFrame = frame();
}

} // namespace os