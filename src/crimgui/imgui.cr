lib ImGui
  # enums
  @[Flags]
  enum ImDrawCornerFlags
    TopLeft  = 1 << 0
    TopRight = 1 << 1
    BotLeft  = 1 << 2
    BotRight = 1 << 3
    Top      = TopLeft | TopRight
    Bot      = BotLeft | BotRight
    Left     = TopLeft | BotLeft
    Right    = TopRight | BotRight
    All      = 0xF
  end

  @[Flags]
  enum ImDrawListFlags
    None             = 0
    AntiAliasedLines = 1 << 0
    AntiAliasedFill  = 1 << 1
  end

  @[Flags]
  enum ImFontAtlasFlags
    None               = 0
    NoPowerOfTwoHeight = 1 << 0
    NoMouseCursors     = 1 << 1
  end

  @[Flags]
  enum ImGuiBackendFlags
    None            = 0
    HasGamepad      = 1 << 0
    HasMouseCursors = 1 << 1
    HasSetMousePos  = 1 << 2
  end

  enum ImGuiCol
    Text                  =  0
    TextDisabled          =  1
    WindowBg              =  2
    ChildBg               =  3
    PopupBg               =  4
    Border                =  5
    BorderShadow          =  6
    FrameBg               =  7
    FrameBgHovered        =  8
    FrameBgActive         =  9
    TitleBg               = 10
    TitleBgActive         = 11
    TitleBgCollapsed      = 12
    MenuBarBg             = 13
    ScrollbarBg           = 14
    ScrollbarGrab         = 15
    ScrollbarGrabHovered  = 16
    ScrollbarGrabActive   = 17
    CheckMark             = 18
    SliderGrab            = 19
    SliderGrabActive      = 20
    Button                = 21
    ButtonHovered         = 22
    ButtonActive          = 23
    Header                = 24
    HeaderHovered         = 25
    HeaderActive          = 26
    Separator             = 27
    SeparatorHovered      = 28
    SeparatorActive       = 29
    ResizeGrip            = 30
    ResizeGripHovered     = 31
    ResizeGripActive      = 32
    Tab                   = 33
    TabHovered            = 34
    TabActive             = 35
    TabUnfocused          = 36
    TabUnfocusedActive    = 37
    PlotLines             = 38
    PlotLinesHovered      = 39
    PlotHistogram         = 40
    PlotHistogramHovered  = 41
    TextSelectedBg        = 42
    DragDropTarget        = 43
    NavHighlight          = 44
    NavWindowingHighlight = 45
    NavWindowingDimBg     = 46
    ModalWindowDimBg      = 47
    COUNT                 = 48
  end

  @[Flags]
  enum ImGuiColorEditFlags
    None             = 0
    NoAlpha          = 1 << 1
    NoPicker         = 1 << 2
    NoOptions        = 1 << 3
    NoSmallPreview   = 1 << 4
    NoInputs         = 1 << 5
    NoTooltip        = 1 << 6
    NoLabel          = 1 << 7
    NoSidePreview    = 1 << 8
    NoDragDrop       = 1 << 9
    AlphaBar         = 1 << 16
    AlphaPreview     = 1 << 17
    AlphaPreviewHalf = 1 << 18
    HDR              = 1 << 19
    RGB              = 1 << 20
    HSV              = 1 << 21
    HEX              = 1 << 22
    Uint8            = 1 << 23
    Float            = 1 << 24
    PickerHueBar     = 1 << 25
    PickerHueWheel   = 1 << 26
    InputsMask       = RGB | HSV | HEX
    DataTypeMask     = Uint8 | Float
    PickerMask       = PickerHueWheel | PickerHueBar
    OptionsDefault   = Uint8 | RGB | PickerHueBar
  end

  @[Flags]
  enum ImGuiComboFlags
    None           = 0
    PopupAlignLeft = 1 << 0
    HeightSmall    = 1 << 1
    HeightRegular  = 1 << 2
    HeightLarge    = 1 << 3
    HeightLargest  = 1 << 4
    NoArrowButton  = 1 << 5
    NoPreview      = 1 << 6
    HeightMask     = HeightSmall | HeightRegular | HeightLarge | HeightLargest
  end

  enum ImGuiCond
    Always       = 1 << 0
    Once         = 1 << 1
    FirstUseEver = 1 << 2
    Appearing    = 1 << 3
  end

  @[Flags]
  enum ImGuiConfigFlags
    None                 = 0
    NavEnableKeyboard    = 1 << 0
    NavEnableGamepad     = 1 << 1
    NavEnableSetMousePos = 1 << 2
    NavNoCaptureKeyboard = 1 << 3
    NoMouse              = 1 << 4
    NoMouseCursorChange  = 1 << 5
    IsSRGB               = 1 << 20
    IsTouchScreen        = 1 << 21
  end

  enum ImGuiDataType
    S32    = 0
    U32    = 1
    S64    = 2
    U64    = 3
    Float  = 4
    Double = 5
    COUNT  = 6
  end

  enum ImGuiDir
    None  = -1
    Left  =  0
    Right =  1
    Up    =  2
    Down  =  3
    COUNT =  4
  end

  @[Flags]
  enum ImGuiDragDropFlags
    None                     = 0
    SourceNoPreviewTooltip   = 1 << 0
    SourceNoDisableHover     = 1 << 1
    SourceNoHoldToOpenOthers = 1 << 2
    SourceAllowNullID        = 1 << 3
    SourceExtern             = 1 << 4
    SourceAutoExpirePayload  = 1 << 5
    AcceptBeforeDelivery     = 1 << 10
    AcceptNoDrawDefaultRect  = 1 << 11
    AcceptNoPreviewTooltip   = 1 << 12
    AcceptPeekOnly           = AcceptBeforeDelivery | AcceptNoDrawDefaultRect
  end

  @[Flags]
  enum ImGuiFocusedFlags
    None                = 0
    ChildWindows        = 1 << 0
    RootWindow          = 1 << 1
    AnyWindow           = 1 << 2
    RootAndChildWindows = RootWindow | ChildWindows
  end

  @[Flags]
  enum ImGuiHoveredFlags
    None                         = 0
    ChildWindows                 = 1 << 0
    RootWindow                   = 1 << 1
    AnyWindow                    = 1 << 2
    AllowWhenBlockedByPopup      = 1 << 3
    AllowWhenBlockedByActiveItem = 1 << 5
    AllowWhenOverlapped          = 1 << 6
    AllowWhenDisabled            = 1 << 7
    RectOnly                     = AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped
    RootAndChildWindows          = RootWindow | ChildWindows
  end

  @[Flags]
  enum ImGuiInputTextFlags
    None                = 0
    CharsDecimal        = 1 << 0
    CharsHexadecimal    = 1 << 1
    CharsUppercase      = 1 << 2
    CharsNoBlank        = 1 << 3
    AutoSelectAll       = 1 << 4
    EnterReturnsTrue    = 1 << 5
    CallbackCompletion  = 1 << 6
    CallbackHistory     = 1 << 7
    CallbackAlways      = 1 << 8
    CallbackCharFilter  = 1 << 9
    AllowTabInput       = 1 << 10
    CtrlEnterForNewLine = 1 << 11
    NoHorizontalScroll  = 1 << 12
    AlwaysInsertMode    = 1 << 13
    ReadOnly            = 1 << 14
    Password            = 1 << 15
    NoUndoRedo          = 1 << 16
    CharsScientific     = 1 << 17
    CallbackResize      = 1 << 18
    Multiline           = 1 << 20
  end

  enum ImGuiKey
    Tab        =  0
    LeftArrow  =  1
    RightArrow =  2
    UpArrow    =  3
    DownArrow  =  4
    PageUp     =  5
    PageDown   =  6
    Home       =  7
    End        =  8
    Insert     =  9
    Delete     = 10
    Backspace  = 11
    Space      = 12
    Enter      = 13
    Escape     = 14
    A          = 15
    C          = 16
    V          = 17
    X          = 18
    Y          = 19
    Z          = 20
    COUNT      = 21
  end

  enum ImGuiMouseCursor
    None       = -1
    Arrow      =  0
    TextInput  =  1
    ResizeAll  =  2
    ResizeNS   =  3
    ResizeEW   =  4
    ResizeNESW =  5
    ResizeNWSE =  6
    Hand       =  7
    COUNT      =  8
  end

  enum ImGuiNavInput
    Activate      =  0
    Cancel        =  1
    Input         =  2
    Menu          =  3
    DpadLeft      =  4
    DpadRight     =  5
    DpadUp        =  6
    DpadDown      =  7
    LStickLeft    =  8
    LStickRight   =  9
    LStickUp      = 10
    LStickDown    = 11
    FocusPrev     = 12
    FocusNext     = 13
    TweakSlow     = 14
    TweakFast     = 15
    KeyMenu       = 16
    KeyLeft       = 17
    KeyRight      = 18
    KeyUp         = 19
    KeyDown       = 20
    COUNT         = 21
    InternalStart = KeyMenu
  end

  @[Flags]
  enum ImGuiSelectableFlags
    None             = 0
    DontClosePopups  = 1 << 0
    SpanAllColumns   = 1 << 1
    AllowDoubleClick = 1 << 2
    Disabled         = 1 << 3
  end

  enum ImGuiStyleVar
    Alpha             =  0
    WindowPadding     =  1
    WindowRounding    =  2
    WindowBorderSize  =  3
    WindowMinSize     =  4
    WindowTitleAlign  =  5
    ChildRounding     =  6
    ChildBorderSize   =  7
    PopupRounding     =  8
    PopupBorderSize   =  9
    FramePadding      = 10
    FrameRounding     = 11
    FrameBorderSize   = 12
    ItemSpacing       = 13
    ItemInnerSpacing  = 14
    IndentSpacing     = 15
    ScrollbarSize     = 16
    ScrollbarRounding = 17
    GrabMinSize       = 18
    GrabRounding      = 19
    TabRounding       = 20
    ButtonTextAlign   = 21
    COUNT             = 22
  end

  @[Flags]
  enum ImGuiTabBarFlags
    None                         = 0
    Reorderable                  = 1 << 0
    AutoSelectNewTabs            = 1 << 1
    NoCloseWithMiddleMouseButton = 1 << 2
    NoTabListPopupButton         = 1 << 3
    NoTabListScrollingButtons    = 1 << 4
    NoTooltip                    = 1 << 5
    FittingPolicyResizeDown      = 1 << 6
    FittingPolicyScroll          = 1 << 7
    FittingPolicyMask            = FittingPolicyResizeDown | FittingPolicyScroll
    FittingPolicyDefault         = FittingPolicyResizeDown
  end

  @[Flags]
  enum ImGuiTabItemFlags
    None                         = 0
    UnsavedDocument              = 1 << 0
    SetSelected                  = 1 << 1
    NoCloseWithMiddleMouseButton = 1 << 2
    NoPushId                     = 1 << 3
  end

  @[Flags]
  enum ImGuiTreeNodeFlags
    None                 = 0
    Selected             = 1 << 0
    Framed               = 1 << 1
    AllowItemOverlap     = 1 << 2
    NoTreePushOnOpen     = 1 << 3
    NoAutoOpenOnLog      = 1 << 4
    DefaultOpen          = 1 << 5
    OpenOnDoubleClick    = 1 << 6
    OpenOnArrow          = 1 << 7
    Leaf                 = 1 << 8
    Bullet               = 1 << 9
    FramePadding         = 1 << 10
    NavLeftJumpsBackHere = 1 << 13
    CollapsingHeader     = Framed | NoTreePushOnOpen | NoAutoOpenOnLog
  end

  @[Flags]
  enum ImGuiWindowFlags
    None                      = 0
    NoTitleBar                = 1 << 0
    NoResize                  = 1 << 1
    NoMove                    = 1 << 2
    NoScrollbar               = 1 << 3
    NoScrollWithMouse         = 1 << 4
    NoCollapse                = 1 << 5
    AlwaysAutoResize          = 1 << 6
    NoBackground              = 1 << 7
    NoSavedSettings           = 1 << 8
    NoMouseInputs             = 1 << 9
    MenuBar                   = 1 << 10
    HorizontalScrollbar       = 1 << 11
    NoFocusOnAppearing        = 1 << 12
    NoBringToFrontOnFocus     = 1 << 13
    AlwaysVerticalScrollbar   = 1 << 14
    AlwaysHorizontalScrollbar = 1 << 15
    AlwaysUseWindowPadding    = 1 << 16
    NoNavInputs               = 1 << 18
    NoNavFocus                = 1 << 19
    UnsavedDocument           = 1 << 20
    NoNav                     = NoNavInputs | NoNavFocus
    NoDecoration              = NoTitleBar | NoResize | NoScrollbar | NoCollapse
    NoInputs                  = NoMouseInputs | NoNavInputs | NoNavFocus
    NavFlattened              = 1 << 23
    ChildWindow               = 1 << 24
    Tooltip                   = 1 << 25
    Popup                     = 1 << 26
    Modal                     = 1 << 27
    ChildMenu                 = 1 << 28
  end

  # types
  struct CustomRect
  end

  struct ImColor
  end

  struct ImDrawChannel
  end

  struct ImDrawCmd
  end

  struct ImDrawData
  end

  struct ImDrawList
  end

  struct ImDrawVert
  end

  struct ImFont
  end

  struct ImFontAtlas
  end

  struct ImFontConfig
  end

  struct ImFontGlyph
  end

  struct ImFontGlyphRangesBuilder
  end

  struct ImGuiIO
  end

  struct ImGuiInputTextCallbackData
  end

  struct ImGuiListClipper
  end

  struct ImGuiOnceUponAFrame
  end

  struct ImGuiPayload
  end

  struct ImGuiSizeCallbackData
  end

  struct ImGuiStorage
  end

  struct ImGuiStyle
  end

  struct ImGuiTextBuffer
  end

  struct ImGuiTextFilter
  end

  struct TextRange
  end
end
