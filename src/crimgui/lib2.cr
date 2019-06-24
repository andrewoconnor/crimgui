require "./custom"

@[Link("cimgui")]
lib LibImGui
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
    AllowVtxOffset   = 1 << 2
  end

  @[Flags]
  enum ImFontAtlasFlags
    None               = 0
    NoPowerOfTwoHeight = 1 << 0
    NoMouseCursors     = 1 << 1
  end

  @[Flags]
  enum ImGuiBackendFlags
    None                 = 0
    HasGamepad           = 1 << 0
    HasMouseCursors      = 1 << 1
    HasSetMousePos       = 1 << 2
    RendererHasVtxOffset = 1 << 3
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
    DisplayRGB       = 1 << 20
    DisplayHSV       = 1 << 21
    DisplayHex       = 1 << 22
    Uint8            = 1 << 23
    Float            = 1 << 24
    PickerHueBar     = 1 << 25
    PickerHueWheel   = 1 << 26
    InputRGB         = 1 << 27
    InputHSV         = 1 << 28
    OptionsDefault   = Uint8 | DisplayRGB | InputRGB | PickerHueBar
    DisplayMask      = DisplayRGB | DisplayHSV | DisplayHex
    DataTypeMask     = Uint8 | Float
    PickerMask       = PickerHueWheel | PickerHueBar
    InputMask        = InputRGB | InputHSV
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
    S8     =  0
    U8     =  1
    S16    =  2
    U16    =  3
    S32    =  4
    U32    =  5
    S64    =  6
    U64    =  7
    Float  =  8
    Double =  9
    COUNT  = 10
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
    NoMarkEdited        = 1 << 21
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
    KeyTab        = 17
    KeyLeft       = 18
    KeyRight      = 19
    KeyUp         = 20
    KeyDown       = 21
    COUNT         = 22
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
    Alpha               =  0
    WindowPadding       =  1
    WindowRounding      =  2
    WindowBorderSize    =  3
    WindowMinSize       =  4
    WindowTitleAlign    =  5
    ChildRounding       =  6
    ChildBorderSize     =  7
    PopupRounding       =  8
    PopupBorderSize     =  9
    FramePadding        = 10
    FrameRounding       = 11
    FrameBorderSize     = 12
    ItemSpacing         = 13
    ItemInnerSpacing    = 14
    IndentSpacing       = 15
    ScrollbarSize       = 16
    ScrollbarRounding   = 17
    GrabMinSize         = 18
    GrabRounding        = 19
    TabRounding         = 20
    ButtonTextAlign     = 21
    SelectableTextAlign = 22
    COUNT               = 23
  end

  @[Flags]
  enum ImGuiTabBarFlags
    None                         = 0
    Reorderable                  = 1 << 0
    AutoSelectNewTabs            = 1 << 1
    TabListPopupButton           = 1 << 2
    NoCloseWithMiddleMouseButton = 1 << 3
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

  alias ImDrawIdx = LibC::UShort

  # types
  struct CustomRect
    id : LibC::UInt
    width : LibC::UShort
    height : LibC::UShort
    x : LibC::UShort
    y : LibC::UShort
    glyph_advance_x : LibC::Float
    glyph_offset : ImVec2
    font : ImFont*
  end

  struct ImColor
    value : ImVec4
  end

  struct ImDrawChannel
    _cmd_buffer : ImVector
    _idx_buffer : ImVector
  end

  struct ImDrawCmd
    elem_count : LibC::UInt
    clip_rect : ImVec4
    texture_id : Void*
    vtx_offset : LibC::UInt
    idx_offset : LibC::UInt
    user_callback : Void*
    user_callback_data : Void*
  end

  struct ImDrawData
    valid : Bool
    cmd_lists : ImDrawList**
    cmd_lists_count : LibC::Int
    total_idx_count : LibC::Int
    total_vtx_count : LibC::Int
    display_pos : ImVec2
    display_size : ImVec2
    framebuffer_scale : ImVec2
  end

  struct ImDrawList
    cmd_buffer : ImVector
    idx_buffer : ImVector
    vtx_buffer : ImVector
    flags : ImDrawListFlags
    _data : Void**
    _owner_name : LibC::Char*
    _vtx_current_offset : LibC::UInt
    _vtx_current_idx : LibC::UInt
    _vtx_write_ptr : ImDrawVert*
    _idx_write_ptr : LibC::UShort*
    _clip_rect_stack : ImVector
    _texture_id_stack : ImVector
    _path : ImVector
    _splitter : ImDrawListSplitter
  end

  struct ImDrawListSplitter
    _current : LibC::Int
    _count : LibC::Int
    _channels : ImVector
  end

  struct ImDrawVert
    pos : ImVec2
    uv : ImVec2
    col : LibC::UInt
  end

  struct ImFont
    index_advance_x : ImVector
    fallback_advance_x : LibC::Float
    font_size : LibC::Float
    index_lookup : ImVector
    glyphs : ImVector
    fallback_glyph : ImFontGlyph*
    display_offset : ImVec2
    container_atlas : ImFontAtlas*
    config_data : ImFontConfig*
    config_data_count : LibC::Short
    fallback_char : LibC::UShort
    scale : LibC::Float
    ascent : LibC::Float
    descent : LibC::Float
    metrics_total_surface : LibC::Int
    dirty_lookup_tables : Bool
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
    tex_uv_scale : ImVec2
    tex_uv_white_pixel : ImVec2
    fonts : ImVector
    custom_rects : ImVector
    config_data : ImVector
    custom_rect_ids : LibC::Int[1]
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
    glyph_extra_spacing : ImVec2
    glyph_offset : ImVec2
    glyph_ranges : LibC::UShort*
    glyph_min_advance_x : LibC::Float
    glyph_max_advance_x : LibC::Float
    merge_mode : Bool
    rasterizer_flags : LibC::UInt
    rasterizer_multiply : LibC::Float
    name : LibC::Char[40]
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
    display_size : ImVec2
    delta_time : LibC::Float
    ini_saving_rate : LibC::Float
    ini_filename : LibC::Char*
    log_filename : LibC::Char*
    mouse_double_click_time : LibC::Float
    mouse_double_click_max_dist : LibC::Float
    mouse_drag_threshold : LibC::Float
    key_map : LibC::Int[21]
    key_repeat_delay : LibC::Float
    key_repeat_rate : LibC::Float
    user_data : Void*
    fonts : ImFontAtlas*
    font_global_scale : LibC::Float
    font_allow_user_scaling : Bool
    font_default : ImFont*
    display_framebuffer_scale : ImVec2
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
    mouse_pos : ImVec2
    mouse_down : Bool[5]
    mouse_wheel : LibC::Float
    mouse_wheel_h : LibC::Float
    key_ctrl : Bool
    key_shift : Bool
    key_alt : Bool
    key_super : Bool
    keys_down : Bool[512]
    nav_inputs : LibC::Float[22]
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
    mouse_delta : ImVec2
    mouse_pos_prev : ImVec2
    mouse_clicked_pos : ImVec2[5]
    mouse_clicked_time : LibC::Double[5]
    mouse_clicked : Bool[5]
    mouse_double_clicked : Bool[5]
    mouse_released : Bool[5]
    mouse_down_owned : Bool[5]
    mouse_down_was_double_click : Bool[5]
    mouse_down_duration : LibC::Float[5]
    mouse_down_duration_prev : LibC::Float[5]
    mouse_drag_max_distance_abs : ImVec2[5]
    mouse_drag_max_distance_sqr : LibC::Float[5]
    keys_down_duration : LibC::Float[512]
    keys_down_duration_prev : LibC::Float[512]
    nav_inputs_down_duration : LibC::Float[22]
    nav_inputs_down_duration_prev : LibC::Float[22]
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
    data_type : LibC::Char[33]
    preview : Bool
    delivery : Bool
  end

  struct ImGuiSizeCallbackData
    user_data : Void*
    pos : ImVec2
    current_size : ImVec2
    desired_size : ImVec2
  end

  struct ImGuiStorage
    data : ImVector
  end

  struct ImGuiStyle
    alpha : LibC::Float
    window_padding : ImVec2
    window_rounding : LibC::Float
    window_border_size : LibC::Float
    window_min_size : ImVec2
    window_title_align : ImVec2
    window_menu_button_position : ImGuiDir
    child_rounding : LibC::Float
    child_border_size : LibC::Float
    popup_rounding : LibC::Float
    popup_border_size : LibC::Float
    frame_padding : ImVec2
    frame_rounding : LibC::Float
    frame_border_size : LibC::Float
    item_spacing : ImVec2
    item_inner_spacing : ImVec2
    touch_extra_padding : ImVec2
    indent_spacing : LibC::Float
    columns_min_spacing : LibC::Float
    scrollbar_size : LibC::Float
    scrollbar_rounding : LibC::Float
    grab_min_size : LibC::Float
    grab_rounding : LibC::Float
    tab_rounding : LibC::Float
    tab_border_size : LibC::Float
    button_text_align : ImVec2
    selectable_text_align : ImVec2
    display_window_padding : ImVec2
    display_safe_area_padding : ImVec2
    mouse_cursor_scale : LibC::Float
    anti_aliased_lines : Bool
    anti_aliased_fill : Bool
    curve_tessellation_tol : LibC::Float
    colors : ImVec4[48]
  end

  struct ImGuiTextBuffer
    buf : ImVector
  end

  struct ImGuiTextFilter
    input_buf : LibC::Char[256]
    filters : ImVector
    count_grep : LibC::Int
  end

  struct TextRange
    b : LibC::Char*
    e : LibC::Char*
  end

  # functions
  fun custom_rect_custom_rect = CustomRect_CustomRect : CustomRect*
  fun custom_rect_is_packed = CustomRect_IsPacked(self : CustomRect*) : Bool
  fun custom_rect_destroy = CustomRect_destroy(self : CustomRect*)
  fun im_color_hsv = ImColor_HSV_nonUDT2(self : ImColor*, h : LibC::Float, s : LibC::Float, v : LibC::Float, a : LibC::Float) : ImColor
  fun im_color_im_color = ImColor_ImColor : ImColor*
  fun im_color_im_color = ImColor_ImColorInt(r : LibC::Int, g : LibC::Int, b : LibC::Int, a : LibC::Int) : ImColor*
  fun im_color_im_color = ImColor_ImColorU32(rgba : LibC::UInt) : ImColor*
  fun im_color_im_color = ImColor_ImColorFloat(r : LibC::Float, g : LibC::Float, b : LibC::Float, a : LibC::Float) : ImColor*
  fun im_color_im_color = ImColor_ImColorVec4(col : ImVec4) : ImColor*
  fun im_color_set_hsv = ImColor_SetHSV(self : ImColor*, h : LibC::Float, s : LibC::Float, v : LibC::Float, a : LibC::Float)
  fun im_color_destroy = ImColor_destroy(self : ImColor*)
  fun im_draw_cmd_im_draw_cmd = ImDrawCmd_ImDrawCmd : ImDrawCmd*
  fun im_draw_cmd_destroy = ImDrawCmd_destroy(self : ImDrawCmd*)
  fun im_draw_data_clear = ImDrawData_Clear(self : ImDrawData*)
  fun im_draw_data_de_index_all_buffers = ImDrawData_DeIndexAllBuffers(self : ImDrawData*)
  fun im_draw_data_im_draw_data = ImDrawData_ImDrawData : ImDrawData*
  fun im_draw_data_scale_clip_rects = ImDrawData_ScaleClipRects(self : ImDrawData*, fb_scale : ImVec2)
  fun im_draw_data_destroy = ImDrawData_destroy(self : ImDrawData*)
  fun im_draw_list_splitter_clear = ImDrawListSplitter_Clear(self : ImDrawListSplitter*)
  fun im_draw_list_splitter_clear_free_memory = ImDrawListSplitter_ClearFreeMemory(self : ImDrawListSplitter*)
  fun im_draw_list_splitter_im_draw_list_splitter = ImDrawListSplitter_ImDrawListSplitter : ImDrawListSplitter*
  fun im_draw_list_splitter_merge = ImDrawListSplitter_Merge(self : ImDrawListSplitter*, draw_list : ImDrawList*)
  fun im_draw_list_splitter_set_current_channel = ImDrawListSplitter_SetCurrentChannel(self : ImDrawListSplitter*, draw_list : ImDrawList*, channel_idx : LibC::Int)
  fun im_draw_list_splitter_split = ImDrawListSplitter_Split(self : ImDrawListSplitter*, draw_list : ImDrawList*, count : LibC::Int)
  fun im_draw_list_splitter_destroy = ImDrawListSplitter_destroy(self : ImDrawListSplitter*)
  fun im_draw_list_add_bezier_curve = ImDrawList_AddBezierCurve(self : ImDrawList*, pos0 : ImVec2, cp0 : ImVec2, cp1 : ImVec2, pos1 : ImVec2, col : LibC::UInt, thickness : LibC::Float, num_segments : LibC::Int)
  fun im_draw_list_add_callback = ImDrawList_AddCallback(self : ImDrawList*, callback : Void*, callback_data : Void*)
  fun im_draw_list_add_circle = ImDrawList_AddCircle(self : ImDrawList*, centre : ImVec2, radius : LibC::Float, col : LibC::UInt, num_segments : LibC::Int, thickness : LibC::Float)
  fun im_draw_list_add_circle_filled = ImDrawList_AddCircleFilled(self : ImDrawList*, centre : ImVec2, radius : LibC::Float, col : LibC::UInt, num_segments : LibC::Int)
  fun im_draw_list_add_convex_poly_filled = ImDrawList_AddConvexPolyFilled(self : ImDrawList*, points : ImVec2*, num_points : LibC::Int, col : LibC::UInt)
  fun im_draw_list_add_draw_cmd = ImDrawList_AddDrawCmd(self : ImDrawList*)
  fun im_draw_list_add_image = ImDrawList_AddImage(self : ImDrawList*, user_texture_id : Void*, a : ImVec2, b : ImVec2, uv_a : ImVec2, uv_b : ImVec2, col : LibC::UInt)
  fun im_draw_list_add_image_quad = ImDrawList_AddImageQuad(self : ImDrawList*, user_texture_id : Void*, a : ImVec2, b : ImVec2, c : ImVec2, d : ImVec2, uv_a : ImVec2, uv_b : ImVec2, uv_c : ImVec2, uv_d : ImVec2, col : LibC::UInt)
  fun im_draw_list_add_image_rounded = ImDrawList_AddImageRounded(self : ImDrawList*, user_texture_id : Void*, a : ImVec2, b : ImVec2, uv_a : ImVec2, uv_b : ImVec2, col : LibC::UInt, rounding : LibC::Float, rounding_corners : LibC::Int)
  fun im_draw_list_add_line = ImDrawList_AddLine(self : ImDrawList*, a : ImVec2, b : ImVec2, col : LibC::UInt, thickness : LibC::Float)
  fun im_draw_list_add_polyline = ImDrawList_AddPolyline(self : ImDrawList*, points : ImVec2*, num_points : LibC::Int, col : LibC::UInt, closed : Bool, thickness : LibC::Float)
  fun im_draw_list_add_quad = ImDrawList_AddQuad(self : ImDrawList*, a : ImVec2, b : ImVec2, c : ImVec2, d : ImVec2, col : LibC::UInt, thickness : LibC::Float)
  fun im_draw_list_add_quad_filled = ImDrawList_AddQuadFilled(self : ImDrawList*, a : ImVec2, b : ImVec2, c : ImVec2, d : ImVec2, col : LibC::UInt)
  fun im_draw_list_add_rect = ImDrawList_AddRect(self : ImDrawList*, a : ImVec2, b : ImVec2, col : LibC::UInt, rounding : LibC::Float, rounding_corners_flags : LibC::Int, thickness : LibC::Float)
  fun im_draw_list_add_rect_filled = ImDrawList_AddRectFilled(self : ImDrawList*, a : ImVec2, b : ImVec2, col : LibC::UInt, rounding : LibC::Float, rounding_corners_flags : LibC::Int)
  fun im_draw_list_add_rect_filled_multi_color = ImDrawList_AddRectFilledMultiColor(self : ImDrawList*, a : ImVec2, b : ImVec2, col_upr_left : LibC::UInt, col_upr_right : LibC::UInt, col_bot_right : LibC::UInt, col_bot_left : LibC::UInt)
  fun im_draw_list_add_text = ImDrawList_AddText(self : ImDrawList*, pos : ImVec2, col : LibC::UInt, text_begin : LibC::Char*, text_end : LibC::Char*)
  fun im_draw_list_add_text = ImDrawList_AddTextFontPtr(self : ImDrawList*, font : ImFont*, font_size : LibC::Float, pos : ImVec2, col : LibC::UInt, text_begin : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float, cpu_fine_clip_rect : ImVec4*)
  fun im_draw_list_add_triangle = ImDrawList_AddTriangle(self : ImDrawList*, a : ImVec2, b : ImVec2, c : ImVec2, col : LibC::UInt, thickness : LibC::Float)
  fun im_draw_list_add_triangle_filled = ImDrawList_AddTriangleFilled(self : ImDrawList*, a : ImVec2, b : ImVec2, c : ImVec2, col : LibC::UInt)
  fun im_draw_list_channels_merge = ImDrawList_ChannelsMerge(self : ImDrawList*)
  fun im_draw_list_channels_set_current = ImDrawList_ChannelsSetCurrent(self : ImDrawList*, n : LibC::Int)
  fun im_draw_list_channels_split = ImDrawList_ChannelsSplit(self : ImDrawList*, count : LibC::Int)
  fun im_draw_list_clear = ImDrawList_Clear(self : ImDrawList*)
  fun im_draw_list_clear_free_memory = ImDrawList_ClearFreeMemory(self : ImDrawList*)
  fun im_draw_list_clone_output = ImDrawList_CloneOutput(self : ImDrawList*) : ImDrawList*
  fun im_draw_list_get_clip_rect_max = ImDrawList_GetClipRectMax_nonUDT2(self : ImDrawList*) : ImVec2
  fun im_draw_list_get_clip_rect_min = ImDrawList_GetClipRectMin_nonUDT2(self : ImDrawList*) : ImVec2
  fun im_draw_list_im_draw_list = ImDrawList_ImDrawList(shared_data : Void**) : ImDrawList*
  fun im_draw_list_path_arc_to = ImDrawList_PathArcTo(self : ImDrawList*, centre : ImVec2, radius : LibC::Float, a_min : LibC::Float, a_max : LibC::Float, num_segments : LibC::Int)
  fun im_draw_list_path_arc_to_fast = ImDrawList_PathArcToFast(self : ImDrawList*, centre : ImVec2, radius : LibC::Float, a_min_of_12 : LibC::Int, a_max_of_12 : LibC::Int)
  fun im_draw_list_path_bezier_curve_to = ImDrawList_PathBezierCurveTo(self : ImDrawList*, p1 : ImVec2, p2 : ImVec2, p3 : ImVec2, num_segments : LibC::Int)
  fun im_draw_list_path_clear = ImDrawList_PathClear(self : ImDrawList*)
  fun im_draw_list_path_fill_convex = ImDrawList_PathFillConvex(self : ImDrawList*, col : LibC::UInt)
  fun im_draw_list_path_line_to = ImDrawList_PathLineTo(self : ImDrawList*, pos : ImVec2)
  fun im_draw_list_path_line_to_merge_duplicate = ImDrawList_PathLineToMergeDuplicate(self : ImDrawList*, pos : ImVec2)
  fun im_draw_list_path_rect = ImDrawList_PathRect(self : ImDrawList*, rect_min : ImVec2, rect_max : ImVec2, rounding : LibC::Float, rounding_corners_flags : LibC::Int)
  fun im_draw_list_path_stroke = ImDrawList_PathStroke(self : ImDrawList*, col : LibC::UInt, closed : Bool, thickness : LibC::Float)
  fun im_draw_list_pop_clip_rect = ImDrawList_PopClipRect(self : ImDrawList*)
  fun im_draw_list_pop_texture_id = ImDrawList_PopTextureID(self : ImDrawList*)
  fun im_draw_list_prim_quad_uv = ImDrawList_PrimQuadUV(self : ImDrawList*, a : ImVec2, b : ImVec2, c : ImVec2, d : ImVec2, uv_a : ImVec2, uv_b : ImVec2, uv_c : ImVec2, uv_d : ImVec2, col : LibC::UInt)
  fun im_draw_list_prim_rect = ImDrawList_PrimRect(self : ImDrawList*, a : ImVec2, b : ImVec2, col : LibC::UInt)
  fun im_draw_list_prim_rect_uv = ImDrawList_PrimRectUV(self : ImDrawList*, a : ImVec2, b : ImVec2, uv_a : ImVec2, uv_b : ImVec2, col : LibC::UInt)
  fun im_draw_list_prim_reserve = ImDrawList_PrimReserve(self : ImDrawList*, idx_count : LibC::Int, vtx_count : LibC::Int)
  fun im_draw_list_prim_vtx = ImDrawList_PrimVtx(self : ImDrawList*, pos : ImVec2, uv : ImVec2, col : LibC::UInt)
  fun im_draw_list_prim_write_idx = ImDrawList_PrimWriteIdx(self : ImDrawList*, idx : LibC::UShort)
  fun im_draw_list_prim_write_vtx = ImDrawList_PrimWriteVtx(self : ImDrawList*, pos : ImVec2, uv : ImVec2, col : LibC::UInt)
  fun im_draw_list_push_clip_rect = ImDrawList_PushClipRect(self : ImDrawList*, clip_rect_min : ImVec2, clip_rect_max : ImVec2, intersect_with_current_clip_rect : Bool)
  fun im_draw_list_push_clip_rect_full_screen = ImDrawList_PushClipRectFullScreen(self : ImDrawList*)
  fun im_draw_list_push_texture_id = ImDrawList_PushTextureID(self : ImDrawList*, texture_id : Void*)
  fun im_draw_list_update_clip_rect = ImDrawList_UpdateClipRect(self : ImDrawList*)
  fun im_draw_list_update_texture_id = ImDrawList_UpdateTextureID(self : ImDrawList*)
  fun im_draw_list_destroy = ImDrawList_destroy(self : ImDrawList*)
  fun im_font_atlas_add_custom_rect_font_glyph = ImFontAtlas_AddCustomRectFontGlyph(self : ImFontAtlas*, font : ImFont*, id : LibC::UShort, width : LibC::Int, height : LibC::Int, advance_x : LibC::Float, offset : ImVec2) : LibC::Int
  fun im_font_atlas_add_custom_rect_regular = ImFontAtlas_AddCustomRectRegular(self : ImFontAtlas*, id : LibC::UInt, width : LibC::Int, height : LibC::Int) : LibC::Int
  fun im_font_atlas_add_font = ImFontAtlas_AddFont(self : ImFontAtlas*, font_cfg : ImFontConfig*) : ImFont*
  fun im_font_atlas_add_font_default = ImFontAtlas_AddFontDefault(self : ImFontAtlas*, font_cfg : ImFontConfig*) : ImFont*
  fun im_font_atlas_add_font_from_file_ttf = ImFontAtlas_AddFontFromFileTTF(self : ImFontAtlas*, filename : LibC::Char*, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun im_font_atlas_add_font_from_memory_compressed_base85_ttf = ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self : ImFontAtlas*, compressed_font_data_base85 : LibC::Char*, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun im_font_atlas_add_font_from_memory_compressed_ttf = ImFontAtlas_AddFontFromMemoryCompressedTTF(self : ImFontAtlas*, compressed_font_data : Void*, compressed_font_size : LibC::Int, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun im_font_atlas_add_font_from_memory_ttf = ImFontAtlas_AddFontFromMemoryTTF(self : ImFontAtlas*, font_data : Void*, font_size : LibC::Int, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun im_font_atlas_build = ImFontAtlas_Build(self : ImFontAtlas*) : Bool
  fun im_font_atlas_calc_custom_rect_uv = ImFontAtlas_CalcCustomRectUV(self : ImFontAtlas*, rect : CustomRect*, out_uv_min : ImVec2*, out_uv_max : ImVec2*)
  fun im_font_atlas_clear = ImFontAtlas_Clear(self : ImFontAtlas*)
  fun im_font_atlas_clear_fonts = ImFontAtlas_ClearFonts(self : ImFontAtlas*)
  fun im_font_atlas_clear_input_data = ImFontAtlas_ClearInputData(self : ImFontAtlas*)
  fun im_font_atlas_clear_tex_data = ImFontAtlas_ClearTexData(self : ImFontAtlas*)
  fun im_font_atlas_get_custom_rect_by_index = ImFontAtlas_GetCustomRectByIndex(self : ImFontAtlas*, index : LibC::Int) : CustomRect*
  fun im_font_atlas_get_glyph_ranges_chinese_full = ImFontAtlas_GetGlyphRangesChineseFull(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_chinese_simplified_common = ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_cyrillic = ImFontAtlas_GetGlyphRangesCyrillic(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_default = ImFontAtlas_GetGlyphRangesDefault(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_japanese = ImFontAtlas_GetGlyphRangesJapanese(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_korean = ImFontAtlas_GetGlyphRangesKorean(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_thai = ImFontAtlas_GetGlyphRangesThai(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_glyph_ranges_vietnamese = ImFontAtlas_GetGlyphRangesVietnamese(self : ImFontAtlas*) : LibC::UShort*
  fun im_font_atlas_get_mouse_cursor_tex_data = ImFontAtlas_GetMouseCursorTexData(self : ImFontAtlas*, cursor : ImGuiMouseCursor, out_offset : ImVec2*, out_size : ImVec2*, out_uv_border : ImVec2[2], out_uv_fill : ImVec2[2]) : Bool
  fun im_font_atlas_get_tex_data_as_alpha8 = ImFontAtlas_GetTexDataAsAlpha8(self : ImFontAtlas*, out_pixels : LibC::UChar**, out_width : LibC::Int*, out_height : LibC::Int*, out_bytes_per_pixel : LibC::Int*)
  fun im_font_atlas_get_tex_data_as_rgba32 = ImFontAtlas_GetTexDataAsRGBA32(self : ImFontAtlas*, out_pixels : LibC::UChar**, out_width : LibC::Int*, out_height : LibC::Int*, out_bytes_per_pixel : LibC::Int*)
  fun im_font_atlas_im_font_atlas = ImFontAtlas_ImFontAtlas : ImFontAtlas*
  fun im_font_atlas_is_built = ImFontAtlas_IsBuilt(self : ImFontAtlas*) : Bool
  fun im_font_atlas_set_tex_id = ImFontAtlas_SetTexID(self : ImFontAtlas*, id : Void*)
  fun im_font_atlas_destroy = ImFontAtlas_destroy(self : ImFontAtlas*)
  fun im_font_config_im_font_config = ImFontConfig_ImFontConfig : ImFontConfig*
  fun im_font_config_destroy = ImFontConfig_destroy(self : ImFontConfig*)
  fun im_font_glyph_ranges_builder_add_char = ImFontGlyphRangesBuilder_AddChar(self : ImFontGlyphRangesBuilder*, c : LibC::UShort)
  fun im_font_glyph_ranges_builder_add_ranges = ImFontGlyphRangesBuilder_AddRanges(self : ImFontGlyphRangesBuilder*, ranges : LibC::UShort*)
  fun im_font_glyph_ranges_builder_add_text = ImFontGlyphRangesBuilder_AddText(self : ImFontGlyphRangesBuilder*, text : LibC::Char*, text_end : LibC::Char*)
  fun im_font_glyph_ranges_builder_build_ranges = ImFontGlyphRangesBuilder_BuildRanges(self : ImFontGlyphRangesBuilder*, out_ranges : ImVector*)
  fun im_font_glyph_ranges_builder_clear = ImFontGlyphRangesBuilder_Clear(self : ImFontGlyphRangesBuilder*)
  fun im_font_glyph_ranges_builder_get_bit = ImFontGlyphRangesBuilder_GetBit(self : ImFontGlyphRangesBuilder*, n : LibC::Int) : Bool
  fun im_font_glyph_ranges_builder_im_font_glyph_ranges_builder = ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder : ImFontGlyphRangesBuilder*
  fun im_font_glyph_ranges_builder_set_bit = ImFontGlyphRangesBuilder_SetBit(self : ImFontGlyphRangesBuilder*, n : LibC::Int)
  fun im_font_glyph_ranges_builder_destroy = ImFontGlyphRangesBuilder_destroy(self : ImFontGlyphRangesBuilder*)
  fun im_font_add_glyph = ImFont_AddGlyph(self : ImFont*, c : LibC::UShort, x0 : LibC::Float, y0 : LibC::Float, x1 : LibC::Float, y1 : LibC::Float, u0 : LibC::Float, v0 : LibC::Float, u1 : LibC::Float, v1 : LibC::Float, advance_x : LibC::Float)
  fun im_font_add_remap_char = ImFont_AddRemapChar(self : ImFont*, dst : LibC::UShort, src : LibC::UShort, overwrite_dst : Bool)
  fun im_font_build_lookup_table = ImFont_BuildLookupTable(self : ImFont*)
  fun im_font_calc_text_size_a = ImFont_CalcTextSizeA_nonUDT2(self : ImFont*, size : LibC::Float, max_width : LibC::Float, wrap_width : LibC::Float, text_begin : LibC::Char*, text_end : LibC::Char*, remaining : LibC::Char**) : ImVec2
  fun im_font_calc_word_wrap_position_a = ImFont_CalcWordWrapPositionA(self : ImFont*, scale : LibC::Float, text : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float) : LibC::Char*
  fun im_font_clear_output_data = ImFont_ClearOutputData(self : ImFont*)
  fun im_font_find_glyph = ImFont_FindGlyph(self : ImFont*, c : LibC::UShort) : ImFontGlyph*
  fun im_font_find_glyph_no_fallback = ImFont_FindGlyphNoFallback(self : ImFont*, c : LibC::UShort) : ImFontGlyph*
  fun im_font_get_char_advance = ImFont_GetCharAdvance(self : ImFont*, c : LibC::UShort) : LibC::Float
  fun im_font_get_debug_name = ImFont_GetDebugName(self : ImFont*) : LibC::Char*
  fun im_font_grow_index = ImFont_GrowIndex(self : ImFont*, new_size : LibC::Int)
  fun im_font_im_font = ImFont_ImFont : ImFont*
  fun im_font_is_loaded = ImFont_IsLoaded(self : ImFont*) : Bool
  fun im_font_render_char = ImFont_RenderChar(self : ImFont*, draw_list : ImDrawList*, size : LibC::Float, pos : ImVec2, col : LibC::UInt, c : LibC::UShort)
  fun im_font_render_text = ImFont_RenderText(self : ImFont*, draw_list : ImDrawList*, size : LibC::Float, pos : ImVec2, col : LibC::UInt, clip_rect : ImVec4, text_begin : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float, cpu_fine_clip : Bool)
  fun im_font_set_fallback_char = ImFont_SetFallbackChar(self : ImFont*, c : LibC::UShort)
  fun im_font_destroy = ImFont_destroy(self : ImFont*)
  fun im_gui_io_add_input_character = ImGuiIO_AddInputCharacter(self : ImGuiIO*, c : LibC::UInt)
  fun im_gui_io_add_input_characters_utf8 = ImGuiIO_AddInputCharactersUTF8(self : ImGuiIO*, str : LibC::Char*)
  fun im_gui_io_clear_input_characters = ImGuiIO_ClearInputCharacters(self : ImGuiIO*)
  fun im_gui_io_im_gui_io = ImGuiIO_ImGuiIO : ImGuiIO*
  fun im_gui_io_destroy = ImGuiIO_destroy(self : ImGuiIO*)
  fun im_gui_input_text_callback_data_delete_chars = ImGuiInputTextCallbackData_DeleteChars(self : ImGuiInputTextCallbackData*, pos : LibC::Int, bytes_count : LibC::Int)
  fun im_gui_input_text_callback_data_has_selection = ImGuiInputTextCallbackData_HasSelection(self : ImGuiInputTextCallbackData*) : Bool
  fun im_gui_input_text_callback_data_im_gui_input_text_callback_data = ImGuiInputTextCallbackData_ImGuiInputTextCallbackData : ImGuiInputTextCallbackData*
  fun im_gui_input_text_callback_data_insert_chars = ImGuiInputTextCallbackData_InsertChars(self : ImGuiInputTextCallbackData*, pos : LibC::Int, text : LibC::Char*, text_end : LibC::Char*)
  fun im_gui_input_text_callback_data_destroy = ImGuiInputTextCallbackData_destroy(self : ImGuiInputTextCallbackData*)
  fun im_gui_list_clipper_begin = ImGuiListClipper_Begin(self : ImGuiListClipper*, items_count : LibC::Int, items_height : LibC::Float)
  fun im_gui_list_clipper_end = ImGuiListClipper_End(self : ImGuiListClipper*)
  fun im_gui_list_clipper_im_gui_list_clipper = ImGuiListClipper_ImGuiListClipper(items_count : LibC::Int, items_height : LibC::Float) : ImGuiListClipper*
  fun im_gui_list_clipper_step = ImGuiListClipper_Step(self : ImGuiListClipper*) : Bool
  fun im_gui_list_clipper_destroy = ImGuiListClipper_destroy(self : ImGuiListClipper*)
  fun im_gui_once_upon_a_frame_im_gui_once_upon_a_frame = ImGuiOnceUponAFrame_ImGuiOnceUponAFrame : ImGuiOnceUponAFrame*
  fun im_gui_once_upon_a_frame_destroy = ImGuiOnceUponAFrame_destroy(self : ImGuiOnceUponAFrame*)
  fun im_gui_payload_clear = ImGuiPayload_Clear(self : ImGuiPayload*)
  fun im_gui_payload_im_gui_payload = ImGuiPayload_ImGuiPayload : ImGuiPayload*
  fun im_gui_payload_is_data_type = ImGuiPayload_IsDataType(self : ImGuiPayload*, type : LibC::Char*) : Bool
  fun im_gui_payload_is_delivery = ImGuiPayload_IsDelivery(self : ImGuiPayload*) : Bool
  fun im_gui_payload_is_preview = ImGuiPayload_IsPreview(self : ImGuiPayload*) : Bool
  fun im_gui_payload_destroy = ImGuiPayload_destroy(self : ImGuiPayload*)
  fun im_gui_storage_build_sort_by_key = ImGuiStorage_BuildSortByKey(self : ImGuiStorage*)
  fun im_gui_storage_clear = ImGuiStorage_Clear(self : ImGuiStorage*)
  fun im_gui_storage_get_bool = ImGuiStorage_GetBool(self : ImGuiStorage*, key : LibC::UInt, default_val : Bool) : Bool
  fun im_gui_storage_get_bool_ref = ImGuiStorage_GetBoolRef(self : ImGuiStorage*, key : LibC::UInt, default_val : Bool) : Bool*
  fun im_gui_storage_get_float = ImGuiStorage_GetFloat(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Float) : LibC::Float
  fun im_gui_storage_get_float_ref = ImGuiStorage_GetFloatRef(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Float) : LibC::Float*
  fun im_gui_storage_get_int = ImGuiStorage_GetInt(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Int) : LibC::Int
  fun im_gui_storage_get_int_ref = ImGuiStorage_GetIntRef(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Int) : LibC::Int*
  fun im_gui_storage_get_void_ptr = ImGuiStorage_GetVoidPtr(self : ImGuiStorage*, key : LibC::UInt) : Void*
  fun im_gui_storage_get_void_ptr_ref = ImGuiStorage_GetVoidPtrRef(self : ImGuiStorage*, key : LibC::UInt, default_val : Void*) : Void**
  fun im_gui_storage_set_all_int = ImGuiStorage_SetAllInt(self : ImGuiStorage*, val : LibC::Int)
  fun im_gui_storage_set_bool = ImGuiStorage_SetBool(self : ImGuiStorage*, key : LibC::UInt, val : Bool)
  fun im_gui_storage_set_float = ImGuiStorage_SetFloat(self : ImGuiStorage*, key : LibC::UInt, val : LibC::Float)
  fun im_gui_storage_set_int = ImGuiStorage_SetInt(self : ImGuiStorage*, key : LibC::UInt, val : LibC::Int)
  fun im_gui_storage_set_void_ptr = ImGuiStorage_SetVoidPtr(self : ImGuiStorage*, key : LibC::UInt, val : Void*)
  fun im_gui_style_im_gui_style = ImGuiStyle_ImGuiStyle : ImGuiStyle*
  fun im_gui_style_scale_all_sizes = ImGuiStyle_ScaleAllSizes(self : ImGuiStyle*, scale_factor : LibC::Float)
  fun im_gui_style_destroy = ImGuiStyle_destroy(self : ImGuiStyle*)
  fun im_gui_text_buffer_im_gui_text_buffer = ImGuiTextBuffer_ImGuiTextBuffer : ImGuiTextBuffer*
  fun im_gui_text_buffer_append = ImGuiTextBuffer_append(self : ImGuiTextBuffer*, str : LibC::Char*, str_end : LibC::Char*)
  fun im_gui_text_buffer_appendf = ImGuiTextBuffer_appendf(self : ImGuiTextBuffer*, fmt : LibC::Char*)
  fun im_gui_text_buffer_begin = ImGuiTextBuffer_begin(self : ImGuiTextBuffer*) : LibC::Char*
  fun im_gui_text_buffer_c_str = ImGuiTextBuffer_c_str(self : ImGuiTextBuffer*) : LibC::Char*
  fun im_gui_text_buffer_clear = ImGuiTextBuffer_clear(self : ImGuiTextBuffer*)
  fun im_gui_text_buffer_destroy = ImGuiTextBuffer_destroy(self : ImGuiTextBuffer*)
  fun im_gui_text_buffer_empty = ImGuiTextBuffer_empty(self : ImGuiTextBuffer*) : Bool
  fun im_gui_text_buffer_end = ImGuiTextBuffer_end(self : ImGuiTextBuffer*) : LibC::Char*
  fun im_gui_text_buffer_reserve = ImGuiTextBuffer_reserve(self : ImGuiTextBuffer*, capacity : LibC::Int)
  fun im_gui_text_buffer_size = ImGuiTextBuffer_size(self : ImGuiTextBuffer*) : LibC::Int
  fun im_gui_text_filter_build = ImGuiTextFilter_Build(self : ImGuiTextFilter*)
  fun im_gui_text_filter_clear = ImGuiTextFilter_Clear(self : ImGuiTextFilter*)
  fun im_gui_text_filter_draw = ImGuiTextFilter_Draw(self : ImGuiTextFilter*, label : LibC::Char*, width : LibC::Float) : Bool
  fun im_gui_text_filter_im_gui_text_filter = ImGuiTextFilter_ImGuiTextFilter(default_filter : LibC::Char*) : ImGuiTextFilter*
  fun im_gui_text_filter_is_active = ImGuiTextFilter_IsActive(self : ImGuiTextFilter*) : Bool
  fun im_gui_text_filter_pass_filter = ImGuiTextFilter_PassFilter(self : ImGuiTextFilter*, text : LibC::Char*, text_end : LibC::Char*) : Bool
  fun im_gui_text_filter_destroy = ImGuiTextFilter_destroy(self : ImGuiTextFilter*)
  fun im_vec2_im_vec2 = ImVec2_ImVec2 : ImVec2*
  fun im_vec2_im_vec2 = ImVec2_ImVec2Float(_x : LibC::Float, _y : LibC::Float) : ImVec2*
  fun im_vec2_destroy = ImVec2_destroy(self : ImVec2*)
  fun im_vec4_im_vec4 = ImVec4_ImVec4 : ImVec4*
  fun im_vec4_im_vec4 = ImVec4_ImVec4Float(_x : LibC::Float, _y : LibC::Float, _z : LibC::Float, _w : LibC::Float) : ImVec4*
  fun im_vec4_destroy = ImVec4_destroy(self : ImVec4*)
  fun im_vector_custom_rect_im_vector_custom_rect = ImVector_CustomRect_ImVector_CustomRect : ImVector_CustomRect*
  fun im_vector_custom_rect_im_vector_custom_rect = ImVector_CustomRect_ImVector_CustomRectVector(src : ImVector) : ImVector_CustomRect*
  fun im_vector_custom_rect__grow_capacity = ImVector_CustomRect__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_custom_rect_back = ImVector_CustomRect_back(self : ImVector*) : CustomRect*
  fun im_vector_custom_rect_begin = ImVector_CustomRect_begin(self : ImVector*) : CustomRect*
  fun im_vector_custom_rect_capacity = ImVector_CustomRect_capacity(self : ImVector*) : LibC::Int
  fun im_vector_custom_rect_clear = ImVector_CustomRect_clear(self : ImVector*)
  fun im_vector_custom_rect_destroy = ImVector_CustomRect_destroy(self : ImVector*)
  fun im_vector_custom_rect_empty = ImVector_CustomRect_empty(self : ImVector*) : Bool
  fun im_vector_custom_rect_end = ImVector_CustomRect_end(self : ImVector*) : CustomRect*
  fun im_vector_custom_rect_erase = ImVector_CustomRect_erase(self : ImVector*, it : CustomRect*) : CustomRect*
  fun im_vector_custom_rect_erase = ImVector_CustomRect_eraseTPtr(self : ImVector*, it : CustomRect*, it_last : CustomRect*) : CustomRect*
  fun im_vector_custom_rect_erase_unsorted = ImVector_CustomRect_erase_unsorted(self : ImVector*, it : CustomRect*) : CustomRect*
  fun im_vector_custom_rect_front = ImVector_CustomRect_front(self : ImVector*) : CustomRect*
  fun im_vector_custom_rect_index_from_ptr = ImVector_CustomRect_index_from_ptr(self : ImVector*, it : CustomRect*) : LibC::Int
  fun im_vector_custom_rect_insert = ImVector_CustomRect_insert(self : ImVector*, it : CustomRect*, v : CustomRect) : CustomRect*
  fun im_vector_custom_rect_pop_back = ImVector_CustomRect_pop_back(self : ImVector*)
  fun im_vector_custom_rect_push_back = ImVector_CustomRect_push_back(self : ImVector*, v : CustomRect)
  fun im_vector_custom_rect_push_front = ImVector_CustomRect_push_front(self : ImVector*, v : CustomRect)
  fun im_vector_custom_rect_reserve = ImVector_CustomRect_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_custom_rect_resize = ImVector_CustomRect_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_custom_rect_resize = ImVector_CustomRect_resizeT(self : ImVector*, new_size : LibC::Int, v : CustomRect)
  fun im_vector_custom_rect_size = ImVector_CustomRect_size(self : ImVector*) : LibC::Int
  fun im_vector_custom_rect_size_in_bytes = ImVector_CustomRect_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_custom_rect_swap = ImVector_CustomRect_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_draw_channel_im_vector_im_draw_channel = ImVector_ImDrawChannel_ImVector_ImDrawChannel : ImVector_ImDrawChannel*
  fun im_vector_im_draw_channel_im_vector_im_draw_channel = ImVector_ImDrawChannel_ImVector_ImDrawChannelVector(src : ImVector) : ImVector_ImDrawChannel*
  fun im_vector_im_draw_channel__grow_capacity = ImVector_ImDrawChannel__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_draw_channel_back = ImVector_ImDrawChannel_back(self : ImVector*) : ImDrawChannel*
  fun im_vector_im_draw_channel_begin = ImVector_ImDrawChannel_begin(self : ImVector*) : ImDrawChannel*
  fun im_vector_im_draw_channel_capacity = ImVector_ImDrawChannel_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_channel_clear = ImVector_ImDrawChannel_clear(self : ImVector*)
  fun im_vector_im_draw_channel_destroy = ImVector_ImDrawChannel_destroy(self : ImVector*)
  fun im_vector_im_draw_channel_empty = ImVector_ImDrawChannel_empty(self : ImVector*) : Bool
  fun im_vector_im_draw_channel_end = ImVector_ImDrawChannel_end(self : ImVector*) : ImDrawChannel*
  fun im_vector_im_draw_channel_erase = ImVector_ImDrawChannel_erase(self : ImVector*, it : ImDrawChannel*) : ImDrawChannel*
  fun im_vector_im_draw_channel_erase = ImVector_ImDrawChannel_eraseTPtr(self : ImVector*, it : ImDrawChannel*, it_last : ImDrawChannel*) : ImDrawChannel*
  fun im_vector_im_draw_channel_erase_unsorted = ImVector_ImDrawChannel_erase_unsorted(self : ImVector*, it : ImDrawChannel*) : ImDrawChannel*
  fun im_vector_im_draw_channel_front = ImVector_ImDrawChannel_front(self : ImVector*) : ImDrawChannel*
  fun im_vector_im_draw_channel_index_from_ptr = ImVector_ImDrawChannel_index_from_ptr(self : ImVector*, it : ImDrawChannel*) : LibC::Int
  fun im_vector_im_draw_channel_insert = ImVector_ImDrawChannel_insert(self : ImVector*, it : ImDrawChannel*, v : ImDrawChannel) : ImDrawChannel*
  fun im_vector_im_draw_channel_pop_back = ImVector_ImDrawChannel_pop_back(self : ImVector*)
  fun im_vector_im_draw_channel_push_back = ImVector_ImDrawChannel_push_back(self : ImVector*, v : ImDrawChannel)
  fun im_vector_im_draw_channel_push_front = ImVector_ImDrawChannel_push_front(self : ImVector*, v : ImDrawChannel)
  fun im_vector_im_draw_channel_reserve = ImVector_ImDrawChannel_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_draw_channel_resize = ImVector_ImDrawChannel_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_draw_channel_resize = ImVector_ImDrawChannel_resizeT(self : ImVector*, new_size : LibC::Int, v : ImDrawChannel)
  fun im_vector_im_draw_channel_size = ImVector_ImDrawChannel_size(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_channel_size_in_bytes = ImVector_ImDrawChannel_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_channel_swap = ImVector_ImDrawChannel_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_draw_cmd_im_vector_im_draw_cmd = ImVector_ImDrawCmd_ImVector_ImDrawCmd : ImVector_ImDrawCmd*
  fun im_vector_im_draw_cmd_im_vector_im_draw_cmd = ImVector_ImDrawCmd_ImVector_ImDrawCmdVector(src : ImVector) : ImVector_ImDrawCmd*
  fun im_vector_im_draw_cmd__grow_capacity = ImVector_ImDrawCmd__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_draw_cmd_back = ImVector_ImDrawCmd_back(self : ImVector*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_begin = ImVector_ImDrawCmd_begin(self : ImVector*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_capacity = ImVector_ImDrawCmd_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_cmd_clear = ImVector_ImDrawCmd_clear(self : ImVector*)
  fun im_vector_im_draw_cmd_destroy = ImVector_ImDrawCmd_destroy(self : ImVector*)
  fun im_vector_im_draw_cmd_empty = ImVector_ImDrawCmd_empty(self : ImVector*) : Bool
  fun im_vector_im_draw_cmd_end = ImVector_ImDrawCmd_end(self : ImVector*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_erase = ImVector_ImDrawCmd_erase(self : ImVector*, it : ImDrawCmd*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_erase = ImVector_ImDrawCmd_eraseTPtr(self : ImVector*, it : ImDrawCmd*, it_last : ImDrawCmd*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_erase_unsorted = ImVector_ImDrawCmd_erase_unsorted(self : ImVector*, it : ImDrawCmd*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_front = ImVector_ImDrawCmd_front(self : ImVector*) : ImDrawCmd*
  fun im_vector_im_draw_cmd_index_from_ptr = ImVector_ImDrawCmd_index_from_ptr(self : ImVector*, it : ImDrawCmd*) : LibC::Int
  fun im_vector_im_draw_cmd_insert = ImVector_ImDrawCmd_insert(self : ImVector*, it : ImDrawCmd*, v : ImDrawCmd) : ImDrawCmd*
  fun im_vector_im_draw_cmd_pop_back = ImVector_ImDrawCmd_pop_back(self : ImVector*)
  fun im_vector_im_draw_cmd_push_back = ImVector_ImDrawCmd_push_back(self : ImVector*, v : ImDrawCmd)
  fun im_vector_im_draw_cmd_push_front = ImVector_ImDrawCmd_push_front(self : ImVector*, v : ImDrawCmd)
  fun im_vector_im_draw_cmd_reserve = ImVector_ImDrawCmd_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_draw_cmd_resize = ImVector_ImDrawCmd_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_draw_cmd_resize = ImVector_ImDrawCmd_resizeT(self : ImVector*, new_size : LibC::Int, v : ImDrawCmd)
  fun im_vector_im_draw_cmd_size = ImVector_ImDrawCmd_size(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_cmd_size_in_bytes = ImVector_ImDrawCmd_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_cmd_swap = ImVector_ImDrawCmd_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_draw_idx_im_vector_im_draw_idx = ImVector_ImDrawIdx_ImVector_ImDrawIdx : ImVector_ImDrawIdx*
  fun im_vector_im_draw_idx_im_vector_im_draw_idx = ImVector_ImDrawIdx_ImVector_ImDrawIdxVector(src : ImVector) : ImVector_ImDrawIdx*
  fun im_vector_im_draw_idx__grow_capacity = ImVector_ImDrawIdx__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_draw_idx_back = ImVector_ImDrawIdx_back(self : ImVector*) : LibC::UShort*
  fun im_vector_im_draw_idx_begin = ImVector_ImDrawIdx_begin(self : ImVector*) : LibC::UShort*
  fun im_vector_im_draw_idx_capacity = ImVector_ImDrawIdx_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_idx_clear = ImVector_ImDrawIdx_clear(self : ImVector*)
  fun im_vector_im_draw_idx_destroy = ImVector_ImDrawIdx_destroy(self : ImVector*)
  fun im_vector_im_draw_idx_empty = ImVector_ImDrawIdx_empty(self : ImVector*) : Bool
  fun im_vector_im_draw_idx_end = ImVector_ImDrawIdx_end(self : ImVector*) : LibC::UShort*
  fun im_vector_im_draw_idx_erase = ImVector_ImDrawIdx_erase(self : ImVector*, it : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_draw_idx_erase = ImVector_ImDrawIdx_eraseTPtr(self : ImVector*, it : LibC::UShort*, it_last : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_draw_idx_erase_unsorted = ImVector_ImDrawIdx_erase_unsorted(self : ImVector*, it : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_draw_idx_front = ImVector_ImDrawIdx_front(self : ImVector*) : LibC::UShort*
  fun im_vector_im_draw_idx_index_from_ptr = ImVector_ImDrawIdx_index_from_ptr(self : ImVector*, it : LibC::UShort*) : LibC::Int
  fun im_vector_im_draw_idx_insert = ImVector_ImDrawIdx_insert(self : ImVector*, it : LibC::UShort*, v : LibC::UShort) : LibC::UShort*
  fun im_vector_im_draw_idx_pop_back = ImVector_ImDrawIdx_pop_back(self : ImVector*)
  fun im_vector_im_draw_idx_push_back = ImVector_ImDrawIdx_push_back(self : ImVector*, v : LibC::UShort)
  fun im_vector_im_draw_idx_push_front = ImVector_ImDrawIdx_push_front(self : ImVector*, v : LibC::UShort)
  fun im_vector_im_draw_idx_reserve = ImVector_ImDrawIdx_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_draw_idx_resize = ImVector_ImDrawIdx_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_draw_idx_resize = ImVector_ImDrawIdx_resizeT(self : ImVector*, new_size : LibC::Int, v : LibC::UShort)
  fun im_vector_im_draw_idx_size = ImVector_ImDrawIdx_size(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_idx_size_in_bytes = ImVector_ImDrawIdx_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_idx_swap = ImVector_ImDrawIdx_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_draw_vert_im_vector_im_draw_vert = ImVector_ImDrawVert_ImVector_ImDrawVert : ImVector_ImDrawVert*
  fun im_vector_im_draw_vert_im_vector_im_draw_vert = ImVector_ImDrawVert_ImVector_ImDrawVertVector(src : ImVector) : ImVector_ImDrawVert*
  fun im_vector_im_draw_vert__grow_capacity = ImVector_ImDrawVert__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_draw_vert_back = ImVector_ImDrawVert_back(self : ImVector*) : ImDrawVert*
  fun im_vector_im_draw_vert_begin = ImVector_ImDrawVert_begin(self : ImVector*) : ImDrawVert*
  fun im_vector_im_draw_vert_capacity = ImVector_ImDrawVert_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_vert_clear = ImVector_ImDrawVert_clear(self : ImVector*)
  fun im_vector_im_draw_vert_destroy = ImVector_ImDrawVert_destroy(self : ImVector*)
  fun im_vector_im_draw_vert_empty = ImVector_ImDrawVert_empty(self : ImVector*) : Bool
  fun im_vector_im_draw_vert_end = ImVector_ImDrawVert_end(self : ImVector*) : ImDrawVert*
  fun im_vector_im_draw_vert_erase = ImVector_ImDrawVert_erase(self : ImVector*, it : ImDrawVert*) : ImDrawVert*
  fun im_vector_im_draw_vert_erase = ImVector_ImDrawVert_eraseTPtr(self : ImVector*, it : ImDrawVert*, it_last : ImDrawVert*) : ImDrawVert*
  fun im_vector_im_draw_vert_erase_unsorted = ImVector_ImDrawVert_erase_unsorted(self : ImVector*, it : ImDrawVert*) : ImDrawVert*
  fun im_vector_im_draw_vert_front = ImVector_ImDrawVert_front(self : ImVector*) : ImDrawVert*
  fun im_vector_im_draw_vert_index_from_ptr = ImVector_ImDrawVert_index_from_ptr(self : ImVector*, it : ImDrawVert*) : LibC::Int
  fun im_vector_im_draw_vert_insert = ImVector_ImDrawVert_insert(self : ImVector*, it : ImDrawVert*, v : ImDrawVert) : ImDrawVert*
  fun im_vector_im_draw_vert_pop_back = ImVector_ImDrawVert_pop_back(self : ImVector*)
  fun im_vector_im_draw_vert_push_back = ImVector_ImDrawVert_push_back(self : ImVector*, v : ImDrawVert)
  fun im_vector_im_draw_vert_push_front = ImVector_ImDrawVert_push_front(self : ImVector*, v : ImDrawVert)
  fun im_vector_im_draw_vert_reserve = ImVector_ImDrawVert_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_draw_vert_resize = ImVector_ImDrawVert_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_draw_vert_resize = ImVector_ImDrawVert_resizeT(self : ImVector*, new_size : LibC::Int, v : ImDrawVert)
  fun im_vector_im_draw_vert_size = ImVector_ImDrawVert_size(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_vert_size_in_bytes = ImVector_ImDrawVert_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_draw_vert_swap = ImVector_ImDrawVert_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_font_config_im_vector_im_font_config = ImVector_ImFontConfig_ImVector_ImFontConfig : ImVector_ImFontConfig*
  fun im_vector_im_font_config_im_vector_im_font_config = ImVector_ImFontConfig_ImVector_ImFontConfigVector(src : ImVector) : ImVector_ImFontConfig*
  fun im_vector_im_font_config__grow_capacity = ImVector_ImFontConfig__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_font_config_back = ImVector_ImFontConfig_back(self : ImVector*) : ImFontConfig*
  fun im_vector_im_font_config_begin = ImVector_ImFontConfig_begin(self : ImVector*) : ImFontConfig*
  fun im_vector_im_font_config_capacity = ImVector_ImFontConfig_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_font_config_clear = ImVector_ImFontConfig_clear(self : ImVector*)
  fun im_vector_im_font_config_destroy = ImVector_ImFontConfig_destroy(self : ImVector*)
  fun im_vector_im_font_config_empty = ImVector_ImFontConfig_empty(self : ImVector*) : Bool
  fun im_vector_im_font_config_end = ImVector_ImFontConfig_end(self : ImVector*) : ImFontConfig*
  fun im_vector_im_font_config_erase = ImVector_ImFontConfig_erase(self : ImVector*, it : ImFontConfig*) : ImFontConfig*
  fun im_vector_im_font_config_erase = ImVector_ImFontConfig_eraseTPtr(self : ImVector*, it : ImFontConfig*, it_last : ImFontConfig*) : ImFontConfig*
  fun im_vector_im_font_config_erase_unsorted = ImVector_ImFontConfig_erase_unsorted(self : ImVector*, it : ImFontConfig*) : ImFontConfig*
  fun im_vector_im_font_config_front = ImVector_ImFontConfig_front(self : ImVector*) : ImFontConfig*
  fun im_vector_im_font_config_index_from_ptr = ImVector_ImFontConfig_index_from_ptr(self : ImVector*, it : ImFontConfig*) : LibC::Int
  fun im_vector_im_font_config_insert = ImVector_ImFontConfig_insert(self : ImVector*, it : ImFontConfig*, v : ImFontConfig) : ImFontConfig*
  fun im_vector_im_font_config_pop_back = ImVector_ImFontConfig_pop_back(self : ImVector*)
  fun im_vector_im_font_config_push_back = ImVector_ImFontConfig_push_back(self : ImVector*, v : ImFontConfig)
  fun im_vector_im_font_config_push_front = ImVector_ImFontConfig_push_front(self : ImVector*, v : ImFontConfig)
  fun im_vector_im_font_config_reserve = ImVector_ImFontConfig_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_font_config_resize = ImVector_ImFontConfig_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_font_config_resize = ImVector_ImFontConfig_resizeT(self : ImVector*, new_size : LibC::Int, v : ImFontConfig)
  fun im_vector_im_font_config_size = ImVector_ImFontConfig_size(self : ImVector*) : LibC::Int
  fun im_vector_im_font_config_size_in_bytes = ImVector_ImFontConfig_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_font_config_swap = ImVector_ImFontConfig_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_font_glyph_im_vector_im_font_glyph = ImVector_ImFontGlyph_ImVector_ImFontGlyph : ImVector_ImFontGlyph*
  fun im_vector_im_font_glyph_im_vector_im_font_glyph = ImVector_ImFontGlyph_ImVector_ImFontGlyphVector(src : ImVector) : ImVector_ImFontGlyph*
  fun im_vector_im_font_glyph__grow_capacity = ImVector_ImFontGlyph__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_font_glyph_back = ImVector_ImFontGlyph_back(self : ImVector*) : ImFontGlyph*
  fun im_vector_im_font_glyph_begin = ImVector_ImFontGlyph_begin(self : ImVector*) : ImFontGlyph*
  fun im_vector_im_font_glyph_capacity = ImVector_ImFontGlyph_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_font_glyph_clear = ImVector_ImFontGlyph_clear(self : ImVector*)
  fun im_vector_im_font_glyph_destroy = ImVector_ImFontGlyph_destroy(self : ImVector*)
  fun im_vector_im_font_glyph_empty = ImVector_ImFontGlyph_empty(self : ImVector*) : Bool
  fun im_vector_im_font_glyph_end = ImVector_ImFontGlyph_end(self : ImVector*) : ImFontGlyph*
  fun im_vector_im_font_glyph_erase = ImVector_ImFontGlyph_erase(self : ImVector*, it : ImFontGlyph*) : ImFontGlyph*
  fun im_vector_im_font_glyph_erase = ImVector_ImFontGlyph_eraseTPtr(self : ImVector*, it : ImFontGlyph*, it_last : ImFontGlyph*) : ImFontGlyph*
  fun im_vector_im_font_glyph_erase_unsorted = ImVector_ImFontGlyph_erase_unsorted(self : ImVector*, it : ImFontGlyph*) : ImFontGlyph*
  fun im_vector_im_font_glyph_front = ImVector_ImFontGlyph_front(self : ImVector*) : ImFontGlyph*
  fun im_vector_im_font_glyph_index_from_ptr = ImVector_ImFontGlyph_index_from_ptr(self : ImVector*, it : ImFontGlyph*) : LibC::Int
  fun im_vector_im_font_glyph_insert = ImVector_ImFontGlyph_insert(self : ImVector*, it : ImFontGlyph*, v : ImFontGlyph) : ImFontGlyph*
  fun im_vector_im_font_glyph_pop_back = ImVector_ImFontGlyph_pop_back(self : ImVector*)
  fun im_vector_im_font_glyph_push_back = ImVector_ImFontGlyph_push_back(self : ImVector*, v : ImFontGlyph)
  fun im_vector_im_font_glyph_push_front = ImVector_ImFontGlyph_push_front(self : ImVector*, v : ImFontGlyph)
  fun im_vector_im_font_glyph_reserve = ImVector_ImFontGlyph_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_font_glyph_resize = ImVector_ImFontGlyph_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_font_glyph_resize = ImVector_ImFontGlyph_resizeT(self : ImVector*, new_size : LibC::Int, v : ImFontGlyph)
  fun im_vector_im_font_glyph_size = ImVector_ImFontGlyph_size(self : ImVector*) : LibC::Int
  fun im_vector_im_font_glyph_size_in_bytes = ImVector_ImFontGlyph_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_font_glyph_swap = ImVector_ImFontGlyph_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_font_ptr_im_vector_im_font_ptr = ImVector_ImFontPtr_ImVector_ImFontPtr : ImVector_ImFontPtr*
  fun im_vector_im_font_ptr_im_vector_im_font_ptr = ImVector_ImFontPtr_ImVector_ImFontPtrVector(src : ImVector) : ImVector_ImFontPtr*
  fun im_vector_im_font_ptr__grow_capacity = ImVector_ImFontPtr__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_font_ptr_back = ImVector_ImFontPtr_back(self : ImVector*) : ImFont**
  fun im_vector_im_font_ptr_begin = ImVector_ImFontPtr_begin(self : ImVector*) : ImFont**
  fun im_vector_im_font_ptr_capacity = ImVector_ImFontPtr_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_font_ptr_clear = ImVector_ImFontPtr_clear(self : ImVector*)
  fun im_vector_im_font_ptr_destroy = ImVector_ImFontPtr_destroy(self : ImVector*)
  fun im_vector_im_font_ptr_empty = ImVector_ImFontPtr_empty(self : ImVector*) : Bool
  fun im_vector_im_font_ptr_end = ImVector_ImFontPtr_end(self : ImVector*) : ImFont**
  fun im_vector_im_font_ptr_erase = ImVector_ImFontPtr_erase(self : ImVector*, it : ImFont**) : ImFont**
  fun im_vector_im_font_ptr_erase = ImVector_ImFontPtr_eraseTPtr(self : ImVector*, it : ImFont**, it_last : ImFont**) : ImFont**
  fun im_vector_im_font_ptr_erase_unsorted = ImVector_ImFontPtr_erase_unsorted(self : ImVector*, it : ImFont**) : ImFont**
  fun im_vector_im_font_ptr_front = ImVector_ImFontPtr_front(self : ImVector*) : ImFont**
  fun im_vector_im_font_ptr_index_from_ptr = ImVector_ImFontPtr_index_from_ptr(self : ImVector*, it : ImFont**) : LibC::Int
  fun im_vector_im_font_ptr_insert = ImVector_ImFontPtr_insert(self : ImVector*, it : ImFont**, v : ImFont*) : ImFont**
  fun im_vector_im_font_ptr_pop_back = ImVector_ImFontPtr_pop_back(self : ImVector*)
  fun im_vector_im_font_ptr_push_back = ImVector_ImFontPtr_push_back(self : ImVector*, v : ImFont*)
  fun im_vector_im_font_ptr_push_front = ImVector_ImFontPtr_push_front(self : ImVector*, v : ImFont*)
  fun im_vector_im_font_ptr_reserve = ImVector_ImFontPtr_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_font_ptr_resize = ImVector_ImFontPtr_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_font_ptr_resize = ImVector_ImFontPtr_resizeT(self : ImVector*, new_size : LibC::Int, v : ImFont*)
  fun im_vector_im_font_ptr_size = ImVector_ImFontPtr_size(self : ImVector*) : LibC::Int
  fun im_vector_im_font_ptr_size_in_bytes = ImVector_ImFontPtr_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_font_ptr_swap = ImVector_ImFontPtr_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_texture_id_im_vector_im_texture_id = ImVector_ImTextureID_ImVector_ImTextureID : ImVector_ImTextureID*
  fun im_vector_im_texture_id_im_vector_im_texture_id = ImVector_ImTextureID_ImVector_ImTextureIDVector(src : ImVector) : ImVector_ImTextureID*
  fun im_vector_im_texture_id__grow_capacity = ImVector_ImTextureID__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_texture_id_back = ImVector_ImTextureID_back(self : ImVector*) : Void**
  fun im_vector_im_texture_id_begin = ImVector_ImTextureID_begin(self : ImVector*) : Void**
  fun im_vector_im_texture_id_capacity = ImVector_ImTextureID_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_texture_id_clear = ImVector_ImTextureID_clear(self : ImVector*)
  fun im_vector_im_texture_id_destroy = ImVector_ImTextureID_destroy(self : ImVector*)
  fun im_vector_im_texture_id_empty = ImVector_ImTextureID_empty(self : ImVector*) : Bool
  fun im_vector_im_texture_id_end = ImVector_ImTextureID_end(self : ImVector*) : Void**
  fun im_vector_im_texture_id_erase = ImVector_ImTextureID_erase(self : ImVector*, it : Void**) : Void**
  fun im_vector_im_texture_id_erase = ImVector_ImTextureID_eraseTPtr(self : ImVector*, it : Void**, it_last : Void**) : Void**
  fun im_vector_im_texture_id_erase_unsorted = ImVector_ImTextureID_erase_unsorted(self : ImVector*, it : Void**) : Void**
  fun im_vector_im_texture_id_front = ImVector_ImTextureID_front(self : ImVector*) : Void**
  fun im_vector_im_texture_id_index_from_ptr = ImVector_ImTextureID_index_from_ptr(self : ImVector*, it : Void**) : LibC::Int
  fun im_vector_im_texture_id_insert = ImVector_ImTextureID_insert(self : ImVector*, it : Void**, v : Void*) : Void**
  fun im_vector_im_texture_id_pop_back = ImVector_ImTextureID_pop_back(self : ImVector*)
  fun im_vector_im_texture_id_push_back = ImVector_ImTextureID_push_back(self : ImVector*, v : Void*)
  fun im_vector_im_texture_id_push_front = ImVector_ImTextureID_push_front(self : ImVector*, v : Void*)
  fun im_vector_im_texture_id_reserve = ImVector_ImTextureID_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_texture_id_resize = ImVector_ImTextureID_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_texture_id_resize = ImVector_ImTextureID_resizeT(self : ImVector*, new_size : LibC::Int, v : Void*)
  fun im_vector_im_texture_id_size = ImVector_ImTextureID_size(self : ImVector*) : LibC::Int
  fun im_vector_im_texture_id_size_in_bytes = ImVector_ImTextureID_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_texture_id_swap = ImVector_ImTextureID_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_u32_im_vector_im_u32 = ImVector_ImU32_ImVector_ImU32 : ImVector_ImU32*
  fun im_vector_im_u32_im_vector_im_u32 = ImVector_ImU32_ImVector_ImU32Vector(src : ImVector) : ImVector_ImU32*
  fun im_vector_im_u32__grow_capacity = ImVector_ImU32__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_u32_back = ImVector_ImU32_back(self : ImVector*) : LibC::UInt*
  fun im_vector_im_u32_begin = ImVector_ImU32_begin(self : ImVector*) : LibC::UInt*
  fun im_vector_im_u32_capacity = ImVector_ImU32_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_u32_clear = ImVector_ImU32_clear(self : ImVector*)
  fun im_vector_im_u32_destroy = ImVector_ImU32_destroy(self : ImVector*)
  fun im_vector_im_u32_empty = ImVector_ImU32_empty(self : ImVector*) : Bool
  fun im_vector_im_u32_end = ImVector_ImU32_end(self : ImVector*) : LibC::UInt*
  fun im_vector_im_u32_erase = ImVector_ImU32_erase(self : ImVector*, it : LibC::UInt*) : LibC::UInt*
  fun im_vector_im_u32_erase = ImVector_ImU32_eraseTPtr(self : ImVector*, it : LibC::UInt*, it_last : LibC::UInt*) : LibC::UInt*
  fun im_vector_im_u32_erase_unsorted = ImVector_ImU32_erase_unsorted(self : ImVector*, it : LibC::UInt*) : LibC::UInt*
  fun im_vector_im_u32_front = ImVector_ImU32_front(self : ImVector*) : LibC::UInt*
  fun im_vector_im_u32_index_from_ptr = ImVector_ImU32_index_from_ptr(self : ImVector*, it : LibC::UInt*) : LibC::Int
  fun im_vector_im_u32_insert = ImVector_ImU32_insert(self : ImVector*, it : LibC::UInt*, v : LibC::UInt) : LibC::UInt*
  fun im_vector_im_u32_pop_back = ImVector_ImU32_pop_back(self : ImVector*)
  fun im_vector_im_u32_push_back = ImVector_ImU32_push_back(self : ImVector*, v : LibC::UInt)
  fun im_vector_im_u32_push_front = ImVector_ImU32_push_front(self : ImVector*, v : LibC::UInt)
  fun im_vector_im_u32_reserve = ImVector_ImU32_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_u32_resize = ImVector_ImU32_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_u32_resize = ImVector_ImU32_resizeT(self : ImVector*, new_size : LibC::Int, v : LibC::UInt)
  fun im_vector_im_u32_size = ImVector_ImU32_size(self : ImVector*) : LibC::Int
  fun im_vector_im_u32_size_in_bytes = ImVector_ImU32_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_u32_swap = ImVector_ImU32_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_vec2_im_vector_im_vec2 = ImVector_ImVec2_ImVector_ImVec2 : ImVector_ImVec2*
  fun im_vector_im_vec2_im_vector_im_vec2 = ImVector_ImVec2_ImVector_ImVec2Vector(src : ImVector) : ImVector_ImVec2*
  fun im_vector_im_vec2__grow_capacity = ImVector_ImVec2__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_vec2_back = ImVector_ImVec2_back(self : ImVector*) : ImVec2*
  fun im_vector_im_vec2_begin = ImVector_ImVec2_begin(self : ImVector*) : ImVec2*
  fun im_vector_im_vec2_capacity = ImVector_ImVec2_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_vec2_clear = ImVector_ImVec2_clear(self : ImVector*)
  fun im_vector_im_vec2_destroy = ImVector_ImVec2_destroy(self : ImVector*)
  fun im_vector_im_vec2_empty = ImVector_ImVec2_empty(self : ImVector*) : Bool
  fun im_vector_im_vec2_end = ImVector_ImVec2_end(self : ImVector*) : ImVec2*
  fun im_vector_im_vec2_erase = ImVector_ImVec2_erase(self : ImVector*, it : ImVec2*) : ImVec2*
  fun im_vector_im_vec2_erase = ImVector_ImVec2_eraseTPtr(self : ImVector*, it : ImVec2*, it_last : ImVec2*) : ImVec2*
  fun im_vector_im_vec2_erase_unsorted = ImVector_ImVec2_erase_unsorted(self : ImVector*, it : ImVec2*) : ImVec2*
  fun im_vector_im_vec2_front = ImVector_ImVec2_front(self : ImVector*) : ImVec2*
  fun im_vector_im_vec2_index_from_ptr = ImVector_ImVec2_index_from_ptr(self : ImVector*, it : ImVec2*) : LibC::Int
  fun im_vector_im_vec2_insert = ImVector_ImVec2_insert(self : ImVector*, it : ImVec2*, v : ImVec2) : ImVec2*
  fun im_vector_im_vec2_pop_back = ImVector_ImVec2_pop_back(self : ImVector*)
  fun im_vector_im_vec2_push_back = ImVector_ImVec2_push_back(self : ImVector*, v : ImVec2)
  fun im_vector_im_vec2_push_front = ImVector_ImVec2_push_front(self : ImVector*, v : ImVec2)
  fun im_vector_im_vec2_reserve = ImVector_ImVec2_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_vec2_resize = ImVector_ImVec2_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_vec2_resize = ImVector_ImVec2_resizeT(self : ImVector*, new_size : LibC::Int, v : ImVec2)
  fun im_vector_im_vec2_size = ImVector_ImVec2_size(self : ImVector*) : LibC::Int
  fun im_vector_im_vec2_size_in_bytes = ImVector_ImVec2_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_vec2_swap = ImVector_ImVec2_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_vec4_im_vector_im_vec4 = ImVector_ImVec4_ImVector_ImVec4 : ImVector_ImVec4*
  fun im_vector_im_vec4_im_vector_im_vec4 = ImVector_ImVec4_ImVector_ImVec4Vector(src : ImVector) : ImVector_ImVec4*
  fun im_vector_im_vec4__grow_capacity = ImVector_ImVec4__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_vec4_back = ImVector_ImVec4_back(self : ImVector*) : ImVec4*
  fun im_vector_im_vec4_begin = ImVector_ImVec4_begin(self : ImVector*) : ImVec4*
  fun im_vector_im_vec4_capacity = ImVector_ImVec4_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_vec4_clear = ImVector_ImVec4_clear(self : ImVector*)
  fun im_vector_im_vec4_destroy = ImVector_ImVec4_destroy(self : ImVector*)
  fun im_vector_im_vec4_empty = ImVector_ImVec4_empty(self : ImVector*) : Bool
  fun im_vector_im_vec4_end = ImVector_ImVec4_end(self : ImVector*) : ImVec4*
  fun im_vector_im_vec4_erase = ImVector_ImVec4_erase(self : ImVector*, it : ImVec4*) : ImVec4*
  fun im_vector_im_vec4_erase = ImVector_ImVec4_eraseTPtr(self : ImVector*, it : ImVec4*, it_last : ImVec4*) : ImVec4*
  fun im_vector_im_vec4_erase_unsorted = ImVector_ImVec4_erase_unsorted(self : ImVector*, it : ImVec4*) : ImVec4*
  fun im_vector_im_vec4_front = ImVector_ImVec4_front(self : ImVector*) : ImVec4*
  fun im_vector_im_vec4_index_from_ptr = ImVector_ImVec4_index_from_ptr(self : ImVector*, it : ImVec4*) : LibC::Int
  fun im_vector_im_vec4_insert = ImVector_ImVec4_insert(self : ImVector*, it : ImVec4*, v : ImVec4) : ImVec4*
  fun im_vector_im_vec4_pop_back = ImVector_ImVec4_pop_back(self : ImVector*)
  fun im_vector_im_vec4_push_back = ImVector_ImVec4_push_back(self : ImVector*, v : ImVec4)
  fun im_vector_im_vec4_push_front = ImVector_ImVec4_push_front(self : ImVector*, v : ImVec4)
  fun im_vector_im_vec4_reserve = ImVector_ImVec4_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_vec4_resize = ImVector_ImVec4_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_vec4_resize = ImVector_ImVec4_resizeT(self : ImVector*, new_size : LibC::Int, v : ImVec4)
  fun im_vector_im_vec4_size = ImVector_ImVec4_size(self : ImVector*) : LibC::Int
  fun im_vector_im_vec4_size_in_bytes = ImVector_ImVec4_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_vec4_swap = ImVector_ImVec4_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_im_vector = ImVector_ImVector : ImVector*
  fun im_vector_im_vector = ImVector_ImVectorVector(src : ImVector) : ImVector*
  fun im_vector_im_wchar_im_vector_im_wchar = ImVector_ImWchar_ImVector_ImWchar : ImVector_ImWchar*
  fun im_vector_im_wchar_im_vector_im_wchar = ImVector_ImWchar_ImVector_ImWcharVector(src : ImVector) : ImVector_ImWchar*
  fun im_vector_im_wchar__grow_capacity = ImVector_ImWchar__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_im_wchar_back = ImVector_ImWchar_back(self : ImVector*) : LibC::UShort*
  fun im_vector_im_wchar_begin = ImVector_ImWchar_begin(self : ImVector*) : LibC::UShort*
  fun im_vector_im_wchar_capacity = ImVector_ImWchar_capacity(self : ImVector*) : LibC::Int
  fun im_vector_im_wchar_clear = ImVector_ImWchar_clear(self : ImVector*)
  fun im_vector_im_wchar_contains = ImVector_ImWchar_contains(self : ImVector*, v : LibC::UShort) : Bool
  fun im_vector_im_wchar_destroy = ImVector_ImWchar_destroy(self : ImVector*)
  fun im_vector_im_wchar_empty = ImVector_ImWchar_empty(self : ImVector*) : Bool
  fun im_vector_im_wchar_end = ImVector_ImWchar_end(self : ImVector*) : LibC::UShort*
  fun im_vector_im_wchar_erase = ImVector_ImWchar_erase(self : ImVector*, it : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_wchar_erase = ImVector_ImWchar_eraseTPtr(self : ImVector*, it : LibC::UShort*, it_last : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_wchar_erase_unsorted = ImVector_ImWchar_erase_unsorted(self : ImVector*, it : LibC::UShort*) : LibC::UShort*
  fun im_vector_im_wchar_front = ImVector_ImWchar_front(self : ImVector*) : LibC::UShort*
  fun im_vector_im_wchar_index_from_ptr = ImVector_ImWchar_index_from_ptr(self : ImVector*, it : LibC::UShort*) : LibC::Int
  fun im_vector_im_wchar_insert = ImVector_ImWchar_insert(self : ImVector*, it : LibC::UShort*, v : LibC::UShort) : LibC::UShort*
  fun im_vector_im_wchar_pop_back = ImVector_ImWchar_pop_back(self : ImVector*)
  fun im_vector_im_wchar_push_back = ImVector_ImWchar_push_back(self : ImVector*, v : LibC::UShort)
  fun im_vector_im_wchar_push_front = ImVector_ImWchar_push_front(self : ImVector*, v : LibC::UShort)
  fun im_vector_im_wchar_reserve = ImVector_ImWchar_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_im_wchar_resize = ImVector_ImWchar_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_im_wchar_resize = ImVector_ImWchar_resizeT(self : ImVector*, new_size : LibC::Int, v : LibC::UShort)
  fun im_vector_im_wchar_size = ImVector_ImWchar_size(self : ImVector*) : LibC::Int
  fun im_vector_im_wchar_size_in_bytes = ImVector_ImWchar_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_im_wchar_swap = ImVector_ImWchar_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_pair_im_vector_pair = ImVector_Pair_ImVector_Pair : ImVector_Pair*
  fun im_vector_pair_im_vector_pair = ImVector_Pair_ImVector_PairVector(src : ImVector) : ImVector_Pair*
  fun im_vector_pair__grow_capacity = ImVector_Pair__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_pair_back = ImVector_Pair_back(self : ImVector*) : Pair*
  fun im_vector_pair_begin = ImVector_Pair_begin(self : ImVector*) : Pair*
  fun im_vector_pair_capacity = ImVector_Pair_capacity(self : ImVector*) : LibC::Int
  fun im_vector_pair_clear = ImVector_Pair_clear(self : ImVector*)
  fun im_vector_pair_destroy = ImVector_Pair_destroy(self : ImVector*)
  fun im_vector_pair_empty = ImVector_Pair_empty(self : ImVector*) : Bool
  fun im_vector_pair_end = ImVector_Pair_end(self : ImVector*) : Pair*
  fun im_vector_pair_erase = ImVector_Pair_erase(self : ImVector*, it : Pair*) : Pair*
  fun im_vector_pair_erase = ImVector_Pair_eraseTPtr(self : ImVector*, it : Pair*, it_last : Pair*) : Pair*
  fun im_vector_pair_erase_unsorted = ImVector_Pair_erase_unsorted(self : ImVector*, it : Pair*) : Pair*
  fun im_vector_pair_front = ImVector_Pair_front(self : ImVector*) : Pair*
  fun im_vector_pair_index_from_ptr = ImVector_Pair_index_from_ptr(self : ImVector*, it : Pair*) : LibC::Int
  fun im_vector_pair_insert = ImVector_Pair_insert(self : ImVector*, it : Pair*, v : Pair) : Pair*
  fun im_vector_pair_pop_back = ImVector_Pair_pop_back(self : ImVector*)
  fun im_vector_pair_push_back = ImVector_Pair_push_back(self : ImVector*, v : Pair)
  fun im_vector_pair_push_front = ImVector_Pair_push_front(self : ImVector*, v : Pair)
  fun im_vector_pair_reserve = ImVector_Pair_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_pair_resize = ImVector_Pair_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_pair_resize = ImVector_Pair_resizeT(self : ImVector*, new_size : LibC::Int, v : Pair)
  fun im_vector_pair_size = ImVector_Pair_size(self : ImVector*) : LibC::Int
  fun im_vector_pair_size_in_bytes = ImVector_Pair_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_pair_swap = ImVector_Pair_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_text_range_im_vector_text_range = ImVector_TextRange_ImVector_TextRange : ImVector_TextRange*
  fun im_vector_text_range_im_vector_text_range = ImVector_TextRange_ImVector_TextRangeVector(src : ImVector) : ImVector_TextRange*
  fun im_vector_text_range__grow_capacity = ImVector_TextRange__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_text_range_back = ImVector_TextRange_back(self : ImVector*) : TextRange*
  fun im_vector_text_range_begin = ImVector_TextRange_begin(self : ImVector*) : TextRange*
  fun im_vector_text_range_capacity = ImVector_TextRange_capacity(self : ImVector*) : LibC::Int
  fun im_vector_text_range_clear = ImVector_TextRange_clear(self : ImVector*)
  fun im_vector_text_range_destroy = ImVector_TextRange_destroy(self : ImVector*)
  fun im_vector_text_range_empty = ImVector_TextRange_empty(self : ImVector*) : Bool
  fun im_vector_text_range_end = ImVector_TextRange_end(self : ImVector*) : TextRange*
  fun im_vector_text_range_erase = ImVector_TextRange_erase(self : ImVector*, it : TextRange*) : TextRange*
  fun im_vector_text_range_erase = ImVector_TextRange_eraseTPtr(self : ImVector*, it : TextRange*, it_last : TextRange*) : TextRange*
  fun im_vector_text_range_erase_unsorted = ImVector_TextRange_erase_unsorted(self : ImVector*, it : TextRange*) : TextRange*
  fun im_vector_text_range_front = ImVector_TextRange_front(self : ImVector*) : TextRange*
  fun im_vector_text_range_index_from_ptr = ImVector_TextRange_index_from_ptr(self : ImVector*, it : TextRange*) : LibC::Int
  fun im_vector_text_range_insert = ImVector_TextRange_insert(self : ImVector*, it : TextRange*, v : TextRange) : TextRange*
  fun im_vector_text_range_pop_back = ImVector_TextRange_pop_back(self : ImVector*)
  fun im_vector_text_range_push_back = ImVector_TextRange_push_back(self : ImVector*, v : TextRange)
  fun im_vector_text_range_push_front = ImVector_TextRange_push_front(self : ImVector*, v : TextRange)
  fun im_vector_text_range_reserve = ImVector_TextRange_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_text_range_resize = ImVector_TextRange_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_text_range_resize = ImVector_TextRange_resizeT(self : ImVector*, new_size : LibC::Int, v : TextRange)
  fun im_vector_text_range_size = ImVector_TextRange_size(self : ImVector*) : LibC::Int
  fun im_vector_text_range_size_in_bytes = ImVector_TextRange_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_text_range_swap = ImVector_TextRange_swap(self : ImVector*, rhs : ImVector)
  fun im_vector__grow_capacity = ImVector__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_back = ImVector_back(self : ImVector*) : T*
  fun im_vector_begin = ImVector_begin(self : ImVector*) : T*
  fun im_vector_capacity = ImVector_capacity(self : ImVector*) : LibC::Int
  fun im_vector_char_im_vector_char = ImVector_char_ImVector_char : ImVector_char*
  fun im_vector_char_im_vector_char = ImVector_char_ImVector_charVector(src : ImVector) : ImVector_char*
  fun im_vector_char__grow_capacity = ImVector_char__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_char_back = ImVector_char_back(self : ImVector*) : LibC::Char*
  fun im_vector_char_begin = ImVector_char_begin(self : ImVector*) : LibC::Char*
  fun im_vector_char_capacity = ImVector_char_capacity(self : ImVector*) : LibC::Int
  fun im_vector_char_clear = ImVector_char_clear(self : ImVector*)
  fun im_vector_char_contains = ImVector_char_contains(self : ImVector*, v : LibC::Char) : Bool
  fun im_vector_char_destroy = ImVector_char_destroy(self : ImVector*)
  fun im_vector_char_empty = ImVector_char_empty(self : ImVector*) : Bool
  fun im_vector_char_end = ImVector_char_end(self : ImVector*) : LibC::Char*
  fun im_vector_char_erase = ImVector_char_erase(self : ImVector*, it : LibC::Char*) : LibC::Char*
  fun im_vector_char_erase = ImVector_char_eraseTPtr(self : ImVector*, it : LibC::Char*, it_last : LibC::Char*) : LibC::Char*
  fun im_vector_char_erase_unsorted = ImVector_char_erase_unsorted(self : ImVector*, it : LibC::Char*) : LibC::Char*
  fun im_vector_char_front = ImVector_char_front(self : ImVector*) : LibC::Char*
  fun im_vector_char_index_from_ptr = ImVector_char_index_from_ptr(self : ImVector*, it : LibC::Char*) : LibC::Int
  fun im_vector_char_insert = ImVector_char_insert(self : ImVector*, it : LibC::Char*, v : LibC::Char) : LibC::Char*
  fun im_vector_char_pop_back = ImVector_char_pop_back(self : ImVector*)
  fun im_vector_char_push_back = ImVector_char_push_back(self : ImVector*, v : LibC::Char)
  fun im_vector_char_push_front = ImVector_char_push_front(self : ImVector*, v : LibC::Char)
  fun im_vector_char_reserve = ImVector_char_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_char_resize = ImVector_char_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_char_resize = ImVector_char_resizeT(self : ImVector*, new_size : LibC::Int, v : LibC::Char)
  fun im_vector_char_size = ImVector_char_size(self : ImVector*) : LibC::Int
  fun im_vector_char_size_in_bytes = ImVector_char_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_char_swap = ImVector_char_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_clear = ImVector_clear(self : ImVector*)
  fun im_vector_destroy = ImVector_destroy(self : ImVector*)
  fun im_vector_empty = ImVector_empty(self : ImVector*) : Bool
  fun im_vector_end = ImVector_end(self : ImVector*) : T*
  fun im_vector_erase = ImVector_erase(self : ImVector*, it : T*) : T*
  fun im_vector_erase = ImVector_eraseTPtr(self : ImVector*, it : T*, it_last : T*) : T*
  fun im_vector_erase_unsorted = ImVector_erase_unsorted(self : ImVector*, it : T*) : T*
  fun im_vector_float_im_vector_float = ImVector_float_ImVector_float : ImVector_float*
  fun im_vector_float_im_vector_float = ImVector_float_ImVector_floatVector(src : ImVector) : ImVector_float*
  fun im_vector_float__grow_capacity = ImVector_float__grow_capacity(self : ImVector*, sz : LibC::Int) : LibC::Int
  fun im_vector_float_back = ImVector_float_back(self : ImVector*) : LibC::Float*
  fun im_vector_float_begin = ImVector_float_begin(self : ImVector*) : LibC::Float*
  fun im_vector_float_capacity = ImVector_float_capacity(self : ImVector*) : LibC::Int
  fun im_vector_float_clear = ImVector_float_clear(self : ImVector*)
  fun im_vector_float_contains = ImVector_float_contains(self : ImVector*, v : LibC::Float) : Bool
  fun im_vector_float_destroy = ImVector_float_destroy(self : ImVector*)
  fun im_vector_float_empty = ImVector_float_empty(self : ImVector*) : Bool
  fun im_vector_float_end = ImVector_float_end(self : ImVector*) : LibC::Float*
  fun im_vector_float_erase = ImVector_float_erase(self : ImVector*, it : LibC::Float*) : LibC::Float*
  fun im_vector_float_erase = ImVector_float_eraseTPtr(self : ImVector*, it : LibC::Float*, it_last : LibC::Float*) : LibC::Float*
  fun im_vector_float_erase_unsorted = ImVector_float_erase_unsorted(self : ImVector*, it : LibC::Float*) : LibC::Float*
  fun im_vector_float_front = ImVector_float_front(self : ImVector*) : LibC::Float*
  fun im_vector_float_index_from_ptr = ImVector_float_index_from_ptr(self : ImVector*, it : LibC::Float*) : LibC::Int
  fun im_vector_float_insert = ImVector_float_insert(self : ImVector*, it : LibC::Float*, v : LibC::Float) : LibC::Float*
  fun im_vector_float_pop_back = ImVector_float_pop_back(self : ImVector*)
  fun im_vector_float_push_back = ImVector_float_push_back(self : ImVector*, v : LibC::Float)
  fun im_vector_float_push_front = ImVector_float_push_front(self : ImVector*, v : LibC::Float)
  fun im_vector_float_reserve = ImVector_float_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_float_resize = ImVector_float_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_float_resize = ImVector_float_resizeT(self : ImVector*, new_size : LibC::Int, v : LibC::Float)
  fun im_vector_float_size = ImVector_float_size(self : ImVector*) : LibC::Int
  fun im_vector_float_size_in_bytes = ImVector_float_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_float_swap = ImVector_float_swap(self : ImVector*, rhs : ImVector)
  fun im_vector_front = ImVector_front(self : ImVector*) : T*
  fun im_vector_index_from_ptr = ImVector_index_from_ptr(self : ImVector*, it : T*) : LibC::Int
  fun im_vector_insert = ImVector_insert(self : ImVector*, it : T*, v : T) : T*
  fun im_vector_pop_back = ImVector_pop_back(self : ImVector*)
  fun im_vector_push_back = ImVector_push_back(self : ImVector*, v : T)
  fun im_vector_push_front = ImVector_push_front(self : ImVector*, v : T)
  fun im_vector_reserve = ImVector_reserve(self : ImVector*, new_capacity : LibC::Int)
  fun im_vector_resize = ImVector_resize(self : ImVector*, new_size : LibC::Int)
  fun im_vector_resize = ImVector_resizeT(self : ImVector*, new_size : LibC::Int, v : T)
  fun im_vector_size = ImVector_size(self : ImVector*) : LibC::Int
  fun im_vector_size_in_bytes = ImVector_size_in_bytes(self : ImVector*) : LibC::Int
  fun im_vector_swap = ImVector_swap(self : ImVector*, rhs : ImVector)
  fun pair_pair = Pair_PairInt(_key : LibC::UInt, _val_i : LibC::Int) : Pair*
  fun pair_pair = Pair_PairFloat(_key : LibC::UInt, _val_f : LibC::Float) : Pair*
  fun pair_pair = Pair_PairPtr(_key : LibC::UInt, _val_p : Void*) : Pair*
  fun pair_destroy = Pair_destroy(self : Pair*)
  fun text_range_text_range = TextRange_TextRange : TextRange*
  fun text_range_text_range = TextRange_TextRangeStr(_b : LibC::Char*, _e : LibC::Char*) : TextRange*
  fun text_range_begin = TextRange_begin(self : TextRange*) : LibC::Char*
  fun text_range_destroy = TextRange_destroy(self : TextRange*)
  fun text_range_empty = TextRange_empty(self : TextRange*) : Bool
  fun text_range_end = TextRange_end(self : TextRange*) : LibC::Char*
  fun text_range_split = TextRange_split(self : TextRange*, separator : LibC::Char, out : ImVector*)
  fun accept_drag_drop_payload = igAcceptDragDropPayload(type : LibC::Char*, flags : ImGuiDragDropFlags) : ImGuiPayload*
  fun align_text_to_frame_padding = igAlignTextToFramePadding
  fun arrow_button = igArrowButton(str_id : LibC::Char*, dir : ImGuiDir) : Bool
  fun begin = igBegin(name : LibC::Char*, p_open : Bool*, flags : ImGuiWindowFlags) : Bool
  fun begin_child = igBeginChild(str_id : LibC::Char*, size : ImVec2, border : Bool, flags : ImGuiWindowFlags) : Bool
  fun begin_child = igBeginChildID(id : LibC::UInt, size : ImVec2, border : Bool, flags : ImGuiWindowFlags) : Bool
  fun begin_child_frame = igBeginChildFrame(id : LibC::UInt, size : ImVec2, flags : ImGuiWindowFlags) : Bool
  fun begin_combo = igBeginCombo(label : LibC::Char*, preview_value : LibC::Char*, flags : ImGuiComboFlags) : Bool
  fun begin_drag_drop_source = igBeginDragDropSource(flags : ImGuiDragDropFlags) : Bool
  fun begin_drag_drop_target = igBeginDragDropTarget : Bool
  fun begin_group = igBeginGroup
  fun begin_main_menu_bar = igBeginMainMenuBar : Bool
  fun begin_menu = igBeginMenu(label : LibC::Char*, enabled : Bool) : Bool
  fun begin_menu_bar = igBeginMenuBar : Bool
  fun begin_popup = igBeginPopup(str_id : LibC::Char*, flags : ImGuiWindowFlags) : Bool
  fun begin_popup_context_item = igBeginPopupContextItem(str_id : LibC::Char*, mouse_button : LibC::Int) : Bool
  fun begin_popup_context_void = igBeginPopupContextVoid(str_id : LibC::Char*, mouse_button : LibC::Int) : Bool
  fun begin_popup_context_window = igBeginPopupContextWindow(str_id : LibC::Char*, mouse_button : LibC::Int, also_over_items : Bool) : Bool
  fun begin_popup_modal = igBeginPopupModal(name : LibC::Char*, p_open : Bool*, flags : ImGuiWindowFlags) : Bool
  fun begin_tab_bar = igBeginTabBar(str_id : LibC::Char*, flags : ImGuiTabBarFlags) : Bool
  fun begin_tab_item = igBeginTabItem(label : LibC::Char*, p_open : Bool*, flags : ImGuiTabItemFlags) : Bool
  fun begin_tooltip = igBeginTooltip
  fun bullet = igBullet
  fun bullet_text = igBulletText(fmt : LibC::Char*)
  fun button = igButton(label : LibC::Char*, size : ImVec2) : Bool
  fun calc_item_width = igCalcItemWidth : LibC::Float
  fun calc_list_clipping = igCalcListClipping(items_count : LibC::Int, items_height : LibC::Float, out_items_display_start : LibC::Int*, out_items_display_end : LibC::Int*)
  fun calc_text_size = igCalcTextSize_nonUDT2(text : LibC::Char*, text_end : LibC::Char*, hide_text_after_double_hash : Bool, wrap_width : LibC::Float) : ImVec2
  fun capture_keyboard_from_app = igCaptureKeyboardFromApp(want_capture_keyboard_value : Bool)
  fun capture_mouse_from_app = igCaptureMouseFromApp(want_capture_mouse_value : Bool)
  fun checkbox = igCheckbox(label : LibC::Char*, v : Bool*) : Bool
  fun checkbox_flags = igCheckboxFlags(label : LibC::Char*, flags : LibC::UInt*, flags_value : LibC::UInt) : Bool
  fun close_current_popup = igCloseCurrentPopup
  fun collapsing_header = igCollapsingHeader(label : LibC::Char*, flags : ImGuiTreeNodeFlags) : Bool
  fun collapsing_header = igCollapsingHeaderBoolPtr(label : LibC::Char*, p_open : Bool*, flags : ImGuiTreeNodeFlags) : Bool
  fun color_button = igColorButton(desc_id : LibC::Char*, col : ImVec4, flags : ImGuiColorEditFlags, size : ImVec2) : Bool
  fun color_convert_float4_to_u32 = igColorConvertFloat4ToU32(in : ImVec4) : LibC::UInt
  fun color_convert_hs_vto_rgb = igColorConvertHSVtoRGB(h : LibC::Float, s : LibC::Float, v : LibC::Float, out_r : LibC::Float*, out_g : LibC::Float*, out_b : LibC::Float*)
  fun color_convert_rg_bto_hsv = igColorConvertRGBtoHSV(r : LibC::Float, g : LibC::Float, b : LibC::Float, out_h : LibC::Float*, out_s : LibC::Float*, out_v : LibC::Float*)
  fun color_convert_u32_to_float4 = igColorConvertU32ToFloat4_nonUDT2(in : LibC::UInt) : ImVec4
  fun color_edit3 = igColorEdit3(label : LibC::Char*, col : Vector3*, flags : ImGuiColorEditFlags) : Bool
  fun color_edit4 = igColorEdit4(label : LibC::Char*, col : Vector4*, flags : ImGuiColorEditFlags) : Bool
  fun color_picker3 = igColorPicker3(label : LibC::Char*, col : Vector3*, flags : ImGuiColorEditFlags) : Bool
  fun color_picker4 = igColorPicker4(label : LibC::Char*, col : Vector4*, flags : ImGuiColorEditFlags, ref_col : LibC::Float*) : Bool
  fun columns = igColumns(count : LibC::Int, id : LibC::Char*, border : Bool)
  fun combo = igCombo(label : LibC::Char*, current_item : LibC::Int*, items : LibC::Char**, items_count : LibC::Int, popup_max_height_in_items : LibC::Int) : Bool
  fun combo = igComboStr(label : LibC::Char*, current_item : LibC::Int*, items_separated_by_zeros : LibC::Char*, popup_max_height_in_items : LibC::Int) : Bool
  fun create_context = igCreateContext(shared_font_atlas : ImFontAtlas*) : Void*
  fun debug_check_version_and_data_layout = igDebugCheckVersionAndDataLayout(version_str : LibC::Char*, sz_io : LibC::SizeT, sz_style : LibC::SizeT, sz_vec2 : LibC::SizeT, sz_vec4 : LibC::SizeT, sz_drawvert : LibC::SizeT, sz_drawidx : LibC::SizeT) : Bool
  fun destroy_context = igDestroyContext(ctx : Void*)
  fun drag_float = igDragFloat(label : LibC::Char*, v : LibC::Float*, v_speed : LibC::Float, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun drag_float2 = igDragFloat2(label : LibC::Char*, v : Vector2*, v_speed : LibC::Float, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun drag_float3 = igDragFloat3(label : LibC::Char*, v : Vector3*, v_speed : LibC::Float, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun drag_float4 = igDragFloat4(label : LibC::Char*, v : Vector4*, v_speed : LibC::Float, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun drag_float_range2 = igDragFloatRange2(label : LibC::Char*, v_current_min : LibC::Float*, v_current_max : LibC::Float*, v_speed : LibC::Float, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, format_max : LibC::Char*, power : LibC::Float) : Bool
  fun drag_int = igDragInt(label : LibC::Char*, v : LibC::Int*, v_speed : LibC::Float, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun drag_int2 = igDragInt2(label : LibC::Char*, v : LibC::Int[2], v_speed : LibC::Float, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun drag_int3 = igDragInt3(label : LibC::Char*, v : LibC::Int[3], v_speed : LibC::Float, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun drag_int4 = igDragInt4(label : LibC::Char*, v : LibC::Int[4], v_speed : LibC::Float, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun drag_int_range2 = igDragIntRange2(label : LibC::Char*, v_current_min : LibC::Int*, v_current_max : LibC::Int*, v_speed : LibC::Float, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*, format_max : LibC::Char*) : Bool
  fun drag_scalar = igDragScalar(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, v_speed : LibC::Float, v_min : Void*, v_max : Void*, format : LibC::Char*, power : LibC::Float) : Bool
  fun drag_scalar_n = igDragScalarN(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, components : LibC::Int, v_speed : LibC::Float, v_min : Void*, v_max : Void*, format : LibC::Char*, power : LibC::Float) : Bool
  fun dummy = igDummy(size : ImVec2)
  fun end = igEnd
  fun end_child = igEndChild
  fun end_child_frame = igEndChildFrame
  fun end_combo = igEndCombo
  fun end_drag_drop_source = igEndDragDropSource
  fun end_drag_drop_target = igEndDragDropTarget
  fun end_frame = igEndFrame
  fun end_group = igEndGroup
  fun end_main_menu_bar = igEndMainMenuBar
  fun end_menu = igEndMenu
  fun end_menu_bar = igEndMenuBar
  fun end_popup = igEndPopup
  fun end_tab_bar = igEndTabBar
  fun end_tab_item = igEndTabItem
  fun end_tooltip = igEndTooltip
  fun get_background_draw_list = igGetBackgroundDrawList : ImDrawList*
  fun get_clipboard_text = igGetClipboardText : LibC::Char*
  fun get_color_u32 = igGetColorU32(idx : ImGuiCol, alpha_mul : LibC::Float) : LibC::UInt
  fun get_color_u32 = igGetColorU32Vec4(col : ImVec4) : LibC::UInt
  fun get_color_u32 = igGetColorU32U32(col : LibC::UInt) : LibC::UInt
  fun get_column_index = igGetColumnIndex : LibC::Int
  fun get_column_offset = igGetColumnOffset(column_index : LibC::Int) : LibC::Float
  fun get_column_width = igGetColumnWidth(column_index : LibC::Int) : LibC::Float
  fun get_columns_count = igGetColumnsCount : LibC::Int
  fun get_content_region_avail = igGetContentRegionAvail_nonUDT2 : ImVec2
  fun get_content_region_max = igGetContentRegionMax_nonUDT2 : ImVec2
  fun get_current_context = igGetCurrentContext : Void**
  fun get_cursor_pos = igGetCursorPos_nonUDT2 : ImVec2
  fun get_cursor_pos_x = igGetCursorPosX : LibC::Float
  fun get_cursor_pos_y = igGetCursorPosY : LibC::Float
  fun get_cursor_screen_pos = igGetCursorScreenPos_nonUDT2 : ImVec2
  fun get_cursor_start_pos = igGetCursorStartPos_nonUDT2 : ImVec2
  fun get_drag_drop_payload = igGetDragDropPayload : ImGuiPayload*
  fun get_draw_data = igGetDrawData : ImDrawData*
  fun get_draw_list_shared_data = igGetDrawListSharedData : Void**
  fun get_font = igGetFont : ImFont*
  fun get_font_size = igGetFontSize : LibC::Float
  fun get_font_tex_uv_white_pixel = igGetFontTexUvWhitePixel_nonUDT2 : ImVec2
  fun get_foreground_draw_list = igGetForegroundDrawList : ImDrawList*
  fun get_frame_count = igGetFrameCount : LibC::Int
  fun get_frame_height = igGetFrameHeight : LibC::Float
  fun get_frame_height_with_spacing = igGetFrameHeightWithSpacing : LibC::Float
  fun get_id = igGetIDStr(str_id : LibC::Char*) : LibC::UInt
  fun get_id = igGetIDRange(str_id_begin : LibC::Char*, str_id_end : LibC::Char*) : LibC::UInt
  fun get_id = igGetIDPtr(ptr_id : Void*) : LibC::UInt
  fun get_io = igGetIO : ImGuiIO*
  fun get_item_rect_max = igGetItemRectMax_nonUDT2 : ImVec2
  fun get_item_rect_min = igGetItemRectMin_nonUDT2 : ImVec2
  fun get_item_rect_size = igGetItemRectSize_nonUDT2 : ImVec2
  fun get_key_index = igGetKeyIndex(imgui_key : ImGuiKey) : LibC::Int
  fun get_key_pressed_amount = igGetKeyPressedAmount(key_index : LibC::Int, repeat_delay : LibC::Float, rate : LibC::Float) : LibC::Int
  fun get_mouse_cursor = igGetMouseCursor : ImGuiMouseCursor
  fun get_mouse_drag_delta = igGetMouseDragDelta_nonUDT2(button : LibC::Int, lock_threshold : LibC::Float) : ImVec2
  fun get_mouse_pos = igGetMousePos_nonUDT2 : ImVec2
  fun get_mouse_pos_on_opening_current_popup = igGetMousePosOnOpeningCurrentPopup_nonUDT2 : ImVec2
  fun get_scroll_max_x = igGetScrollMaxX : LibC::Float
  fun get_scroll_max_y = igGetScrollMaxY : LibC::Float
  fun get_scroll_x = igGetScrollX : LibC::Float
  fun get_scroll_y = igGetScrollY : LibC::Float
  fun get_state_storage = igGetStateStorage : ImGuiStorage*
  fun get_style = igGetStyle : ImGuiStyle*
  fun get_style_color_name = igGetStyleColorName(idx : ImGuiCol) : LibC::Char*
  fun get_style_color_vec4 = igGetStyleColorVec4(idx : ImGuiCol) : ImVec4*
  fun get_text_line_height = igGetTextLineHeight : LibC::Float
  fun get_text_line_height_with_spacing = igGetTextLineHeightWithSpacing : LibC::Float
  fun get_time = igGetTime : LibC::Double
  fun get_tree_node_to_label_spacing = igGetTreeNodeToLabelSpacing : LibC::Float
  fun get_version = igGetVersion : LibC::Char*
  fun get_window_content_region_max = igGetWindowContentRegionMax_nonUDT2 : ImVec2
  fun get_window_content_region_min = igGetWindowContentRegionMin_nonUDT2 : ImVec2
  fun get_window_content_region_width = igGetWindowContentRegionWidth : LibC::Float
  fun get_window_draw_list = igGetWindowDrawList : ImDrawList*
  fun get_window_height = igGetWindowHeight : LibC::Float
  fun get_window_pos = igGetWindowPos_nonUDT2 : ImVec2
  fun get_window_size = igGetWindowSize_nonUDT2 : ImVec2
  fun get_window_width = igGetWindowWidth : LibC::Float
  fun image = igImage(user_texture_id : Void*, size : ImVec2, uv0 : ImVec2, uv1 : ImVec2, tint_col : ImVec4, border_col : ImVec4)
  fun image_button = igImageButton(user_texture_id : Void*, size : ImVec2, uv0 : ImVec2, uv1 : ImVec2, frame_padding : LibC::Int, bg_col : ImVec4, tint_col : ImVec4) : Bool
  fun indent = igIndent(indent_w : LibC::Float)
  fun input_double = igInputDouble(label : LibC::Char*, v : LibC::Double*, step : LibC::Double, step_fast : LibC::Double, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_float = igInputFloat(label : LibC::Char*, v : LibC::Float*, step : LibC::Float, step_fast : LibC::Float, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_float2 = igInputFloat2(label : LibC::Char*, v : Vector2*, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_float3 = igInputFloat3(label : LibC::Char*, v : Vector3*, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_float4 = igInputFloat4(label : LibC::Char*, v : Vector4*, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_int = igInputInt(label : LibC::Char*, v : LibC::Int*, step : LibC::Int, step_fast : LibC::Int, flags : ImGuiInputTextFlags) : Bool
  fun input_int2 = igInputInt2(label : LibC::Char*, v : LibC::Int[2], flags : ImGuiInputTextFlags) : Bool
  fun input_int3 = igInputInt3(label : LibC::Char*, v : LibC::Int[3], flags : ImGuiInputTextFlags) : Bool
  fun input_int4 = igInputInt4(label : LibC::Char*, v : LibC::Int[4], flags : ImGuiInputTextFlags) : Bool
  fun input_scalar = igInputScalar(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, step : Void*, step_fast : Void*, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_scalar_n = igInputScalarN(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, components : LibC::Int, step : Void*, step_fast : Void*, format : LibC::Char*, flags : ImGuiInputTextFlags) : Bool
  fun input_text = igInputText(label : LibC::Char*, buf : LibC::Char*, buf_size : LibC::SizeT, flags : ImGuiInputTextFlags, callback : ImGuiInputTextCallback, user_data : Void*) : Bool
  fun input_text_multiline = igInputTextMultiline(label : LibC::Char*, buf : LibC::Char*, buf_size : LibC::SizeT, size : ImVec2, flags : ImGuiInputTextFlags, callback : ImGuiInputTextCallback, user_data : Void*) : Bool
  fun input_text_with_hint = igInputTextWithHint(label : LibC::Char*, hint : LibC::Char*, buf : LibC::Char*, buf_size : LibC::SizeT, flags : ImGuiInputTextFlags, callback : ImGuiInputTextCallback, user_data : Void*) : Bool
  fun invisible_button = igInvisibleButton(str_id : LibC::Char*, size : ImVec2) : Bool
  fun is_any_item_active = igIsAnyItemActive : Bool
  fun is_any_item_focused = igIsAnyItemFocused : Bool
  fun is_any_item_hovered = igIsAnyItemHovered : Bool
  fun is_any_mouse_down = igIsAnyMouseDown : Bool
  fun is_item_activated = igIsItemActivated : Bool
  fun is_item_active = igIsItemActive : Bool
  fun is_item_clicked = igIsItemClicked(mouse_button : LibC::Int) : Bool
  fun is_item_deactivated = igIsItemDeactivated : Bool
  fun is_item_deactivated_after_edit = igIsItemDeactivatedAfterEdit : Bool
  fun is_item_edited = igIsItemEdited : Bool
  fun is_item_focused = igIsItemFocused : Bool
  fun is_item_hovered = igIsItemHovered(flags : ImGuiHoveredFlags) : Bool
  fun is_item_visible = igIsItemVisible : Bool
  fun is_key_down = igIsKeyDown(user_key_index : LibC::Int) : Bool
  fun is_key_pressed = igIsKeyPressed(user_key_index : LibC::Int, repeat : Bool) : Bool
  fun is_key_released = igIsKeyReleased(user_key_index : LibC::Int) : Bool
  fun is_mouse_clicked = igIsMouseClicked(button : LibC::Int, repeat : Bool) : Bool
  fun is_mouse_double_clicked = igIsMouseDoubleClicked(button : LibC::Int) : Bool
  fun is_mouse_down = igIsMouseDown(button : LibC::Int) : Bool
  fun is_mouse_dragging = igIsMouseDragging(button : LibC::Int, lock_threshold : LibC::Float) : Bool
  fun is_mouse_hovering_rect = igIsMouseHoveringRect(r_min : ImVec2, r_max : ImVec2, clip : Bool) : Bool
  fun is_mouse_pos_valid = igIsMousePosValid(mouse_pos : ImVec2*) : Bool
  fun is_mouse_released = igIsMouseReleased(button : LibC::Int) : Bool
  fun is_popup_open = igIsPopupOpen(str_id : LibC::Char*) : Bool
  fun is_rect_visible = igIsRectVisible(size : ImVec2) : Bool
  fun is_rect_visible = igIsRectVisibleVec2(rect_min : ImVec2, rect_max : ImVec2) : Bool
  fun is_window_appearing = igIsWindowAppearing : Bool
  fun is_window_collapsed = igIsWindowCollapsed : Bool
  fun is_window_focused = igIsWindowFocused(flags : ImGuiFocusedFlags) : Bool
  fun is_window_hovered = igIsWindowHovered(flags : ImGuiHoveredFlags) : Bool
  fun label_text = igLabelText(label : LibC::Char*, fmt : LibC::Char*)
  fun list_box = igListBoxStr_arr(label : LibC::Char*, current_item : LibC::Int*, items : LibC::Char**, items_count : LibC::Int, height_in_items : LibC::Int) : Bool
  fun list_box_footer = igListBoxFooter
  fun list_box_header = igListBoxHeaderVec2(label : LibC::Char*, size : ImVec2) : Bool
  fun list_box_header = igListBoxHeaderInt(label : LibC::Char*, items_count : LibC::Int, height_in_items : LibC::Int) : Bool
  fun load_ini_settings_from_disk = igLoadIniSettingsFromDisk(ini_filename : LibC::Char*)
  fun load_ini_settings_from_memory = igLoadIniSettingsFromMemory(ini_data : LibC::Char*, ini_size : LibC::SizeT)
  fun log_buttons = igLogButtons
  fun log_finish = igLogFinish
  fun log_text = igLogText(fmt : LibC::Char*)
  fun log_to_clipboard = igLogToClipboard(auto_open_depth : LibC::Int)
  fun log_to_file = igLogToFile(auto_open_depth : LibC::Int, filename : LibC::Char*)
  fun log_to_tty = igLogToTTY(auto_open_depth : LibC::Int)
  fun mem_alloc = igMemAlloc(size : LibC::SizeT) : Void*
  fun mem_free = igMemFree(ptr : Void*)
  fun menu_item = igMenuItemBool(label : LibC::Char*, shortcut : LibC::Char*, selected : Bool, enabled : Bool) : Bool
  fun menu_item = igMenuItemBoolPtr(label : LibC::Char*, shortcut : LibC::Char*, p_selected : Bool*, enabled : Bool) : Bool
  fun new_frame = igNewFrame
  fun new_line = igNewLine
  fun next_column = igNextColumn
  fun open_popup = igOpenPopup(str_id : LibC::Char*)
  fun open_popup_on_item_click = igOpenPopupOnItemClick(str_id : LibC::Char*, mouse_button : LibC::Int) : Bool
  fun plot_histogram = igPlotHistogramFloatPtr(label : LibC::Char*, values : LibC::Float*, values_count : LibC::Int, values_offset : LibC::Int, overlay_text : LibC::Char*, scale_min : LibC::Float, scale_max : LibC::Float, graph_size : ImVec2, stride : LibC::Int)
  fun plot_lines = igPlotLines(label : LibC::Char*, values : LibC::Float*, values_count : LibC::Int, values_offset : LibC::Int, overlay_text : LibC::Char*, scale_min : LibC::Float, scale_max : LibC::Float, graph_size : ImVec2, stride : LibC::Int)
  fun pop_allow_keyboard_focus = igPopAllowKeyboardFocus
  fun pop_button_repeat = igPopButtonRepeat
  fun pop_clip_rect = igPopClipRect
  fun pop_font = igPopFont
  fun pop_id = igPopID
  fun pop_item_width = igPopItemWidth
  fun pop_style_color = igPopStyleColor(count : LibC::Int)
  fun pop_style_var = igPopStyleVar(count : LibC::Int)
  fun pop_text_wrap_pos = igPopTextWrapPos
  fun progress_bar = igProgressBar(fraction : LibC::Float, size_arg : ImVec2, overlay : LibC::Char*)
  fun push_allow_keyboard_focus = igPushAllowKeyboardFocus(allow_keyboard_focus : Bool)
  fun push_button_repeat = igPushButtonRepeat(repeat : Bool)
  fun push_clip_rect = igPushClipRect(clip_rect_min : ImVec2, clip_rect_max : ImVec2, intersect_with_current_clip_rect : Bool)
  fun push_font = igPushFont(font : ImFont*)
  fun push_id = igPushIDStr(str_id : LibC::Char*)
  fun push_id = igPushIDRange(str_id_begin : LibC::Char*, str_id_end : LibC::Char*)
  fun push_id = igPushIDPtr(ptr_id : Void*)
  fun push_id = igPushIDInt(int_id : LibC::Int)
  fun push_item_width = igPushItemWidth(item_width : LibC::Float)
  fun push_style_color = igPushStyleColorU32(idx : ImGuiCol, col : LibC::UInt)
  fun push_style_color = igPushStyleColor(idx : ImGuiCol, col : ImVec4)
  fun push_style_var = igPushStyleVarFloat(idx : ImGuiStyleVar, val : LibC::Float)
  fun push_style_var = igPushStyleVarVec2(idx : ImGuiStyleVar, val : ImVec2)
  fun push_text_wrap_pos = igPushTextWrapPos(wrap_local_pos_x : LibC::Float)
  fun radio_button = igRadioButtonBool(label : LibC::Char*, active : Bool) : Bool
  fun radio_button = igRadioButtonIntPtr(label : LibC::Char*, v : LibC::Int*, v_button : LibC::Int) : Bool
  fun render = igRender
  fun reset_mouse_drag_delta = igResetMouseDragDelta(button : LibC::Int)
  fun same_line = igSameLine(offset_from_start_x : LibC::Float, spacing : LibC::Float)
  fun save_ini_settings_to_disk = igSaveIniSettingsToDisk(ini_filename : LibC::Char*)
  fun save_ini_settings_to_memory = igSaveIniSettingsToMemory(out_ini_size : LibC::SizeT*) : LibC::Char*
  fun selectable = igSelectable(label : LibC::Char*, selected : Bool, flags : ImGuiSelectableFlags, size : ImVec2) : Bool
  fun selectable = igSelectableBoolPtr(label : LibC::Char*, p_selected : Bool*, flags : ImGuiSelectableFlags, size : ImVec2) : Bool
  fun separator = igSeparator
  fun set_clipboard_text = igSetClipboardText(text : LibC::Char*)
  fun set_color_edit_options = igSetColorEditOptions(flags : ImGuiColorEditFlags)
  fun set_column_offset = igSetColumnOffset(column_index : LibC::Int, offset_x : LibC::Float)
  fun set_column_width = igSetColumnWidth(column_index : LibC::Int, width : LibC::Float)
  fun set_current_context = igSetCurrentContext(ctx : Void**)
  fun set_cursor_pos = igSetCursorPos(local_pos : ImVec2)
  fun set_cursor_pos_x = igSetCursorPosX(local_x : LibC::Float)
  fun set_cursor_pos_y = igSetCursorPosY(local_y : LibC::Float)
  fun set_cursor_screen_pos = igSetCursorScreenPos(pos : ImVec2)
  fun set_drag_drop_payload = igSetDragDropPayload(type : LibC::Char*, data : Void*, sz : LibC::SizeT, cond : ImGuiCond) : Bool
  fun set_item_allow_overlap = igSetItemAllowOverlap
  fun set_item_default_focus = igSetItemDefaultFocus
  fun set_keyboard_focus_here = igSetKeyboardFocusHere(offset : LibC::Int)
  fun set_mouse_cursor = igSetMouseCursor(type : ImGuiMouseCursor)
  fun set_next_item_open = igSetNextItemOpen(is_open : Bool, cond : ImGuiCond)
  fun set_next_item_width = igSetNextItemWidth(item_width : LibC::Float)
  fun set_next_window_bg_alpha = igSetNextWindowBgAlpha(alpha : LibC::Float)
  fun set_next_window_collapsed = igSetNextWindowCollapsed(collapsed : Bool, cond : ImGuiCond)
  fun set_next_window_content_size = igSetNextWindowContentSize(size : ImVec2)
  fun set_next_window_focus = igSetNextWindowFocus
  fun set_next_window_pos = igSetNextWindowPos(pos : ImVec2, cond : ImGuiCond, pivot : ImVec2)
  fun set_next_window_size = igSetNextWindowSize(size : ImVec2, cond : ImGuiCond)
  fun set_next_window_size_constraints = igSetNextWindowSizeConstraints(size_min : ImVec2, size_max : ImVec2, custom_callback : ImGuiSizeCallback, custom_callback_data : Void*)
  fun set_scroll_from_pos_y = igSetScrollFromPosY(local_y : LibC::Float, center_y_ratio : LibC::Float)
  fun set_scroll_here_y = igSetScrollHereY(center_y_ratio : LibC::Float)
  fun set_scroll_x = igSetScrollX(scroll_x : LibC::Float)
  fun set_scroll_y = igSetScrollY(scroll_y : LibC::Float)
  fun set_state_storage = igSetStateStorage(storage : ImGuiStorage*)
  fun set_tab_item_closed = igSetTabItemClosed(tab_or_docked_window_label : LibC::Char*)
  fun set_tooltip = igSetTooltip(fmt : LibC::Char*)
  fun set_window_collapsed = igSetWindowCollapsedBool(collapsed : Bool, cond : ImGuiCond)
  fun set_window_collapsed = igSetWindowCollapsedStr(name : LibC::Char*, collapsed : Bool, cond : ImGuiCond)
  fun set_window_focus = igSetWindowFocus
  fun set_window_focus = igSetWindowFocusStr(name : LibC::Char*)
  fun set_window_font_scale = igSetWindowFontScale(scale : LibC::Float)
  fun set_window_pos = igSetWindowPosVec2(pos : ImVec2, cond : ImGuiCond)
  fun set_window_pos = igSetWindowPosStr(name : LibC::Char*, pos : ImVec2, cond : ImGuiCond)
  fun set_window_size = igSetWindowSizeVec2(size : ImVec2, cond : ImGuiCond)
  fun set_window_size = igSetWindowSizeStr(name : LibC::Char*, size : ImVec2, cond : ImGuiCond)
  fun show_about_window = igShowAboutWindow(p_open : Bool*)
  fun show_demo_window = igShowDemoWindow(p_open : Bool*)
  fun show_font_selector = igShowFontSelector(label : LibC::Char*)
  fun show_metrics_window = igShowMetricsWindow(p_open : Bool*)
  fun show_style_editor = igShowStyleEditor(ref : ImGuiStyle*)
  fun show_style_selector = igShowStyleSelector(label : LibC::Char*) : Bool
  fun show_user_guide = igShowUserGuide
  fun slider_angle = igSliderAngle(label : LibC::Char*, v_rad : LibC::Float*, v_degrees_min : LibC::Float, v_degrees_max : LibC::Float, format : LibC::Char*) : Bool
  fun slider_float = igSliderFloat(label : LibC::Char*, v : LibC::Float*, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun slider_float2 = igSliderFloat2(label : LibC::Char*, v : Vector2*, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun slider_float3 = igSliderFloat3(label : LibC::Char*, v : Vector3*, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun slider_float4 = igSliderFloat4(label : LibC::Char*, v : Vector4*, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun slider_int = igSliderInt(label : LibC::Char*, v : LibC::Int*, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun slider_int2 = igSliderInt2(label : LibC::Char*, v : LibC::Int[2], v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun slider_int3 = igSliderInt3(label : LibC::Char*, v : LibC::Int[3], v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun slider_int4 = igSliderInt4(label : LibC::Char*, v : LibC::Int[4], v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun slider_scalar = igSliderScalar(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, v_min : Void*, v_max : Void*, format : LibC::Char*, power : LibC::Float) : Bool
  fun slider_scalar_n = igSliderScalarN(label : LibC::Char*, data_type : ImGuiDataType, v : Void*, components : LibC::Int, v_min : Void*, v_max : Void*, format : LibC::Char*, power : LibC::Float) : Bool
  fun small_button = igSmallButton(label : LibC::Char*) : Bool
  fun spacing = igSpacing
  fun style_colors_classic = igStyleColorsClassic(dst : ImGuiStyle*)
  fun style_colors_dark = igStyleColorsDark(dst : ImGuiStyle*)
  fun style_colors_light = igStyleColorsLight(dst : ImGuiStyle*)
  fun text = igText(fmt : LibC::Char*)
  fun text_colored = igTextColored(col : ImVec4, fmt : LibC::Char*)
  fun text_disabled = igTextDisabled(fmt : LibC::Char*)
  fun text_unformatted = igTextUnformatted(text : LibC::Char*, text_end : LibC::Char*)
  fun text_wrapped = igTextWrapped(fmt : LibC::Char*)
  fun tree_advance_to_label_pos = igTreeAdvanceToLabelPos
  fun tree_node = igTreeNodeStr(label : LibC::Char*) : Bool
  fun tree_node = igTreeNodeStrStr(str_id : LibC::Char*, fmt : LibC::Char*) : Bool
  fun tree_node = igTreeNodePtr(ptr_id : Void*, fmt : LibC::Char*) : Bool
  fun tree_node_ex = igTreeNodeExStr(label : LibC::Char*, flags : ImGuiTreeNodeFlags) : Bool
  fun tree_node_ex = igTreeNodeExStrStr(str_id : LibC::Char*, flags : ImGuiTreeNodeFlags, fmt : LibC::Char*) : Bool
  fun tree_node_ex = igTreeNodeExPtr(ptr_id : Void*, flags : ImGuiTreeNodeFlags, fmt : LibC::Char*) : Bool
  fun tree_pop = igTreePop
  fun tree_push = igTreePushStr(str_id : LibC::Char*)
  fun tree_push = igTreePushPtr(ptr_id : Void*)
  fun unindent = igUnindent(indent_w : LibC::Float)
  fun v_slider_float = igVSliderFloat(label : LibC::Char*, size : ImVec2, v : LibC::Float*, v_min : LibC::Float, v_max : LibC::Float, format : LibC::Char*, power : LibC::Float) : Bool
  fun v_slider_int = igVSliderInt(label : LibC::Char*, size : ImVec2, v : LibC::Int*, v_min : LibC::Int, v_max : LibC::Int, format : LibC::Char*) : Bool
  fun v_slider_scalar = igVSliderScalar(label : LibC::Char*, size : ImVec2, data_type : ImGuiDataType, v : Void*, v_min : Void*, v_max : Void*, format : LibC::Char*, power : LibC::Float) : Bool
  fun value = igValueBool(prefix : LibC::Char*, b : Bool)
  fun value = igValueInt(prefix : LibC::Char*, v : LibC::Int)
  fun value = igValueUint(prefix : LibC::Char*, v : LibC::UInt)
  fun value = igValueFloat(prefix : LibC::Char*, v : LibC::Float, float_format : LibC::Char*)
end
