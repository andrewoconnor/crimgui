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
    id : LibC::UInt
    width : LibC::UShort
    height : LibC::UShort
    x : LibC::UShort
    y : LibC::UShort
    glyph_advance_x : LibC::Float
    glyph_offset : Vector2
    font : ImFont*
  end

  struct ImColor
    value : Vector4
  end

  struct ImDrawChannel
    cmd_buffer : ImVector
    idx_buffer : ImVector
  end

  struct ImDrawCmd
    elem_count : LibC::UInt
    clip_rect : Vector4
    texture_id : Void*
    user_callback : Void*
    user_callback_data : Void*
  end

  struct ImDrawData
    valid : Bool
    cmd_lists : ImDrawList**
    cmd_lists_count : LibC::Int
    total_idx_count : LibC::Int
    total_vtx_count : LibC::Int
    display_pos : Vector2
    display_size : Vector2
  end

  struct ImDrawList
    cmd_buffer : ImVector
    idx_buffer : ImVector
    vtx_buffer : ImVector
    flags : ImDrawListFlags
    _data : Void**
    _owner_name : LibC::Char*
    _vtx_current_idx : LibC::UInt
    _vtx_write_ptr : ImDrawVert*
    _idx_write_ptr : LibC::UShort*
    _clip_rect_stack : ImVector
    _texture_id_stack : ImVector
    _path : ImVector
    _channels_current : LibC::Int
    _channels_count : LibC::Int
    _channels : ImVector
  end

  struct ImDrawVert
    pos : Vector2
    uv : Vector2
    col : LibC::UInt
  end

  struct ImFont
    font_size : LibC::Float
    scale : LibC::Float
    display_offset : Vector2
    glyphs : ImVector
    index_advance_x : ImVector
    index_lookup : ImVector
    fallback_glyph : ImFontGlyph*
    fallback_advance_x : LibC::Float
    fallback_char : LibC::UShort
    config_data_count : LibC::Short
    config_data : ImFontConfig*
    container_atlas : ImFontAtlas*
    ascent : LibC::Float
    descent : LibC::Float
    dirty_lookup_tables : Bool
    metrics_total_surface : LibC::Int
  end

  struct ImFontAtlas
    locked : Bool
    flags : ImFontAtlasFlags
    tex_id : Void*
    tex_desired_width : LibC::Int
    tex_glyph_padding : LibC::Int
    tex_pixels_alpha8 : LibC::UChar*
    tex_pixels_rgba32 : LibC::UInt*
    tex_width : LibC::Int
    tex_height : LibC::Int
    tex_uv_scale : Vector2
    tex_uv_white_pixel : Vector2
    fonts : ImVector
    custom_rects : ImVector
    config_data : ImVector
  end

  struct ImFontConfig
    font_data : Void*
    font_data_size : LibC::Int
    font_data_owned_by_atlas : Bool
    font_no : LibC::Int
    size_pixels : LibC::Float
    oversample_h : LibC::Int
    oversample_v : LibC::Int
    pixel_snap_h : Bool
    glyph_extra_spacing : Vector2
    glyph_offset : Vector2
    glyph_ranges : LibC::UShort*
    glyph_min_advance_x : LibC::Float
    glyph_max_advance_x : LibC::Float
    merge_mode : Bool
    rasterizer_flags : LibC::UInt
    rasterizer_multiply : LibC::Float
    dst_font : ImFont*
  end

  struct ImFontGlyph
    codepoint : LibC::UShort
    advance_x : LibC::Float
    x0 : LibC::Float
    y0 : LibC::Float
    x1 : LibC::Float
    y1 : LibC::Float
    u0 : LibC::Float
    v0 : LibC::Float
    u1 : LibC::Float
    v1 : LibC::Float
  end

  struct ImFontGlyphRangesBuilder
    used_chars : ImVector
  end

  struct ImGuiIO
    config_flags : ImGuiConfigFlags
    backend_flags : ImGuiBackendFlags
    display_size : Vector2
    delta_time : LibC::Float
    ini_saving_rate : LibC::Float
    ini_filename : LibC::Char*
    log_filename : LibC::Char*
    mouse_double_click_time : LibC::Float
    mouse_double_click_max_dist : LibC::Float
    mouse_drag_threshold : LibC::Float
    key_repeat_delay : LibC::Float
    key_repeat_rate : LibC::Float
    user_data : Void*
    fonts : ImFontAtlas*
    font_global_scale : LibC::Float
    font_allow_user_scaling : Bool
    font_default : ImFont*
    display_framebuffer_scale : Vector2
    display_visible_min : Vector2
    display_visible_max : Vector2
    mouse_draw_cursor : Bool
    config_mac_osx_behaviors : Bool
    config_input_text_cursor_blink : Bool
    config_windows_resize_from_edges : Bool
    config_windows_move_from_title_bar_only : Bool
    backend_platform_name : LibC::Char*
    backend_renderer_name : LibC::Char*
    backend_platform_user_data : Void*
    backend_renderer_user_data : Void*
    backend_language_user_data : Void*
    get_clipboard_text_fn : Void*
    set_clipboard_text_fn : Void*
    clipboard_user_data : Void*
    ime_set_input_screen_pos_fn : Void*
    ime_window_handle : Void*
    render_draw_lists_fn_unused : Void*
    mouse_pos : Vector2
    mouse_wheel : LibC::Float
    mouse_wheel_h : LibC::Float
    key_ctrl : Bool
    key_shift : Bool
    key_alt : Bool
    key_super : Bool
    want_capture_mouse : Bool
    want_capture_keyboard : Bool
    want_text_input : Bool
    want_set_mouse_pos : Bool
    want_save_ini_settings : Bool
    nav_active : Bool
    nav_visible : Bool
    framerate : LibC::Float
    metrics_render_vertices : LibC::Int
    metrics_render_indices : LibC::Int
    metrics_render_windows : LibC::Int
    metrics_active_windows : LibC::Int
    metrics_active_allocations : LibC::Int
    mouse_delta : Vector2
    mouse_pos_prev : Vector2
    input_queue_characters : ImVector
  end

  struct ImGuiInputTextCallbackData
    event_flag : ImGuiInputTextFlags
    flags : ImGuiInputTextFlags
    user_data : Void*
    event_char : LibC::UShort
    event_key : ImGuiKey
    buf : LibC::Char*
    buf_text_len : LibC::Int
    buf_size : LibC::Int
    buf_dirty : Bool
    cursor_pos : LibC::Int
    selection_start : LibC::Int
    selection_end : LibC::Int
  end

  struct ImGuiListClipper
    start_pos_y : LibC::Float
    items_height : LibC::Float
    items_count : LibC::Int
    step_no : LibC::Int
    display_start : LibC::Int
    display_end : LibC::Int
  end

  struct ImGuiOnceUponAFrame
    ref_frame : LibC::Int
  end

  struct ImGuiPayload
    data : Void*
    data_size : LibC::Int
    source_id : LibC::UInt
    source_parent_id : LibC::UInt
    data_frame_count : LibC::Int
    preview : Bool
    delivery : Bool
  end

  struct ImGuiSizeCallbackData
    user_data : Void*
    pos : Vector2
    current_size : Vector2
    desired_size : Vector2
  end

  struct ImGuiStorage
    data : ImVector
  end

  struct ImGuiStyle
    alpha : LibC::Float
    window_padding : Vector2
    window_rounding : LibC::Float
    window_border_size : LibC::Float
    window_min_size : Vector2
    window_title_align : Vector2
    child_rounding : LibC::Float
    child_border_size : LibC::Float
    popup_rounding : LibC::Float
    popup_border_size : LibC::Float
    frame_padding : Vector2
    frame_rounding : LibC::Float
    frame_border_size : LibC::Float
    item_spacing : Vector2
    item_inner_spacing : Vector2
    touch_extra_padding : Vector2
    indent_spacing : LibC::Float
    columns_min_spacing : LibC::Float
    scrollbar_size : LibC::Float
    scrollbar_rounding : LibC::Float
    grab_min_size : LibC::Float
    grab_rounding : LibC::Float
    tab_rounding : LibC::Float
    tab_border_size : LibC::Float
    button_text_align : Vector2
    display_window_padding : Vector2
    display_safe_area_padding : Vector2
    mouse_cursor_scale : LibC::Float
    anti_aliased_lines : Bool
    anti_aliased_fill : Bool
    curve_tessellation_tol : LibC::Float
  end

  struct ImGuiTextBuffer
    buf : ImVector
  end

  struct ImGuiTextFilter
    filters : ImVector
    count_grep : LibC::Int
  end

  struct TextRange
    b : LibC::Char*
    e : LibC::Char*
  end
end
