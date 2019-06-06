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
  fun imguicontext_allocate = igCreateContext(shared_font_atlas : ImFontAtlas*) : Void*
  fun imguicontext_destroy = igDestroyContext(self : Void*)

  struct CustomRect
    id : LibC::UInt
    width : LibC::UShort
    height : LibC::UShort
    x : LibC::UShort
    y : LibC::UShort
    glyph_advance_x : LibC::Float
    glyph_offset : Void*
    font : ImFont*
  end

  fun customrect_allocate = CustomRect_CustomRect : CustomRect*
  fun customrect_is_packed = CustomRect_IsPacked(self : CustomRect*) : Bool
  fun customrect_destroy = CustomRect_destroy(self : CustomRect*)

  struct ImColor
    value : Void*
  end

  fun imcolor_hsv = ImColor_HSV_nonUDT2(self : ImColor*, h : LibC::Float, s : LibC::Float, v : LibC::Float, a : LibC::Float) : ImColor
  fun imcolor_allocate = ImColor_ImColor : ImColor*
  fun imcolor_allocate = ImColor_ImColorInt(r : LibC::Int, g : LibC::Int, b : LibC::Int, a : LibC::Int) : ImColor*
  fun imcolor_allocate = ImColor_ImColorU32(rgba : LibC::UInt) : ImColor*
  fun imcolor_allocate = ImColor_ImColorFloat(r : LibC::Float, g : LibC::Float, b : LibC::Float, a : LibC::Float) : ImColor*
  fun imcolor_allocate = ImColor_ImColorVec4(col : Void*) : ImColor*
  fun imcolor_set_hsv = ImColor_SetHSV(self : ImColor*, h : LibC::Float, s : LibC::Float, v : LibC::Float, a : LibC::Float)
  fun imcolor_destroy = ImColor_destroy(self : ImColor*)

  struct ImDrawChannel
    cmd_buffer : Void*
    idx_buffer : Void*
  end

  struct ImDrawCmd
    elem_count : LibC::UInt
    clip_rect : Void*
    texture_id : Void*
    user_callback : Void*
    user_callback_data : Void*
  end

  fun imdrawcmd_allocate = ImDrawCmd_ImDrawCmd : ImDrawCmd*
  fun imdrawcmd_destroy = ImDrawCmd_destroy(self : ImDrawCmd*)

  struct ImDrawData
    valid : Bool
    cmd_lists : ImDrawList**
    cmd_lists_count : LibC::Int
    total_idx_count : LibC::Int
    total_vtx_count : LibC::Int
    display_pos : Void*
    display_size : Void*
  end

  fun imdrawdata_clear = ImDrawData_Clear(self : ImDrawData*)
  fun imdrawdata_de_index_all_buffers = ImDrawData_DeIndexAllBuffers(self : ImDrawData*)
  fun imdrawdata_allocate = ImDrawData_ImDrawData : ImDrawData*
  fun imdrawdata_scale_clip_rects = ImDrawData_ScaleClipRects(self : ImDrawData*, sc : Void*)
  fun imdrawdata_destroy = ImDrawData_destroy(self : ImDrawData*)

  struct ImDrawList
    cmd_buffer : Void*
    idx_buffer : Void*
    vtx_buffer : Void*
    flags : ImDrawListFlags
    _data : Void**
    _owner_name : LibC::Char*
    _vtx_current_idx : LibC::UInt
    _vtx_write_ptr : ImDrawVert*
    _idx_write_ptr : LibC::UShort*
    _clip_rect_stack : Void*
    _texture_id_stack : Void*
    _path : Void*
    _channels_current : LibC::Int
    _channels_count : LibC::Int
    _channels : Void*
  end

  fun imdrawlist_add_bezier_curve = ImDrawList_AddBezierCurve(self : ImDrawList*, pos0 : Void*, cp0 : Void*, cp1 : Void*, pos1 : Void*, col : LibC::UInt, thickness : LibC::Float, num_segments : LibC::Int)
  fun imdrawlist_add_callback = ImDrawList_AddCallback(self : ImDrawList*, callback : Void*, callback_data : Void*)
  fun imdrawlist_add_circle = ImDrawList_AddCircle(self : ImDrawList*, centre : Void*, radius : LibC::Float, col : LibC::UInt, num_segments : LibC::Int, thickness : LibC::Float)
  fun imdrawlist_add_circle_filled = ImDrawList_AddCircleFilled(self : ImDrawList*, centre : Void*, radius : LibC::Float, col : LibC::UInt, num_segments : LibC::Int)
  fun imdrawlist_add_convex_poly_filled = ImDrawList_AddConvexPolyFilled(self : ImDrawList*, points : Void**, num_points : LibC::Int, col : LibC::UInt)
  fun imdrawlist_add_draw_cmd = ImDrawList_AddDrawCmd(self : ImDrawList*)
  fun imdrawlist_add_image = ImDrawList_AddImage(self : ImDrawList*, user_texture_id : Void*, a : Void*, b : Void*, uv_a : Void*, uv_b : Void*, col : LibC::UInt)
  fun imdrawlist_add_image_quad = ImDrawList_AddImageQuad(self : ImDrawList*, user_texture_id : Void*, a : Void*, b : Void*, c : Void*, d : Void*, uv_a : Void*, uv_b : Void*, uv_c : Void*, uv_d : Void*, col : LibC::UInt)
  fun imdrawlist_add_image_rounded = ImDrawList_AddImageRounded(self : ImDrawList*, user_texture_id : Void*, a : Void*, b : Void*, uv_a : Void*, uv_b : Void*, col : LibC::UInt, rounding : LibC::Float, rounding_corners : LibC::Int)
  fun imdrawlist_add_line = ImDrawList_AddLine(self : ImDrawList*, a : Void*, b : Void*, col : LibC::UInt, thickness : LibC::Float)
  fun imdrawlist_add_polyline = ImDrawList_AddPolyline(self : ImDrawList*, points : Void**, num_points : LibC::Int, col : LibC::UInt, closed : Bool, thickness : LibC::Float)
  fun imdrawlist_add_quad = ImDrawList_AddQuad(self : ImDrawList*, a : Void*, b : Void*, c : Void*, d : Void*, col : LibC::UInt, thickness : LibC::Float)
  fun imdrawlist_add_quad_filled = ImDrawList_AddQuadFilled(self : ImDrawList*, a : Void*, b : Void*, c : Void*, d : Void*, col : LibC::UInt)
  fun imdrawlist_add_rect = ImDrawList_AddRect(self : ImDrawList*, a : Void*, b : Void*, col : LibC::UInt, rounding : LibC::Float, rounding_corners_flags : LibC::Int, thickness : LibC::Float)
  fun imdrawlist_add_rect_filled = ImDrawList_AddRectFilled(self : ImDrawList*, a : Void*, b : Void*, col : LibC::UInt, rounding : LibC::Float, rounding_corners_flags : LibC::Int)
  fun imdrawlist_add_rect_filled_multi_color = ImDrawList_AddRectFilledMultiColor(self : ImDrawList*, a : Void*, b : Void*, col_upr_left : LibC::UInt, col_upr_right : LibC::UInt, col_bot_right : LibC::UInt, col_bot_left : LibC::UInt)
  fun imdrawlist_add_text = ImDrawList_AddText(self : ImDrawList*, pos : Void*, col : LibC::UInt, text_begin : LibC::Char*, text_end : LibC::Char*)
  fun imdrawlist_add_text = ImDrawList_AddTextFontPtr(self : ImDrawList*, font : ImFont*, font_size : LibC::Float, pos : Void*, col : LibC::UInt, text_begin : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float, cpu_fine_clip_rect : Void**)
  fun imdrawlist_add_triangle = ImDrawList_AddTriangle(self : ImDrawList*, a : Void*, b : Void*, c : Void*, col : LibC::UInt, thickness : LibC::Float)
  fun imdrawlist_add_triangle_filled = ImDrawList_AddTriangleFilled(self : ImDrawList*, a : Void*, b : Void*, c : Void*, col : LibC::UInt)
  fun imdrawlist_channels_merge = ImDrawList_ChannelsMerge(self : ImDrawList*)
  fun imdrawlist_channels_set_current = ImDrawList_ChannelsSetCurrent(self : ImDrawList*, channel_index : LibC::Int)
  fun imdrawlist_channels_split = ImDrawList_ChannelsSplit(self : ImDrawList*, channels_count : LibC::Int)
  fun imdrawlist_clear = ImDrawList_Clear(self : ImDrawList*)
  fun imdrawlist_clear_free_memory = ImDrawList_ClearFreeMemory(self : ImDrawList*)
  fun imdrawlist_clone_output = ImDrawList_CloneOutput(self : ImDrawList*) : ImDrawList*
  fun imdrawlist_get_clip_rect_max = ImDrawList_GetClipRectMax_nonUDT2(self : ImDrawList*) : Void*
  fun imdrawlist_get_clip_rect_min = ImDrawList_GetClipRectMin_nonUDT2(self : ImDrawList*) : Void*
  fun imdrawlist_allocate = ImDrawList_ImDrawList(shared_data : Void**) : ImDrawList*
  fun imdrawlist_path_arc_to = ImDrawList_PathArcTo(self : ImDrawList*, centre : Void*, radius : LibC::Float, a_min : LibC::Float, a_max : LibC::Float, num_segments : LibC::Int)
  fun imdrawlist_path_arc_to_fast = ImDrawList_PathArcToFast(self : ImDrawList*, centre : Void*, radius : LibC::Float, a_min_of_12 : LibC::Int, a_max_of_12 : LibC::Int)
  fun imdrawlist_path_bezier_curve_to = ImDrawList_PathBezierCurveTo(self : ImDrawList*, p1 : Void*, p2 : Void*, p3 : Void*, num_segments : LibC::Int)
  fun imdrawlist_path_clear = ImDrawList_PathClear(self : ImDrawList*)
  fun imdrawlist_path_fill_convex = ImDrawList_PathFillConvex(self : ImDrawList*, col : LibC::UInt)
  fun imdrawlist_path_line_to = ImDrawList_PathLineTo(self : ImDrawList*, pos : Void*)
  fun imdrawlist_path_line_to_merge_duplicate = ImDrawList_PathLineToMergeDuplicate(self : ImDrawList*, pos : Void*)
  fun imdrawlist_path_rect = ImDrawList_PathRect(self : ImDrawList*, rect_min : Void*, rect_max : Void*, rounding : LibC::Float, rounding_corners_flags : LibC::Int)
  fun imdrawlist_path_stroke = ImDrawList_PathStroke(self : ImDrawList*, col : LibC::UInt, closed : Bool, thickness : LibC::Float)
  fun imdrawlist_pop_clip_rect = ImDrawList_PopClipRect(self : ImDrawList*)
  fun imdrawlist_pop_texture_id = ImDrawList_PopTextureID(self : ImDrawList*)
  fun imdrawlist_prim_quad_uv = ImDrawList_PrimQuadUV(self : ImDrawList*, a : Void*, b : Void*, c : Void*, d : Void*, uv_a : Void*, uv_b : Void*, uv_c : Void*, uv_d : Void*, col : LibC::UInt)
  fun imdrawlist_prim_rect = ImDrawList_PrimRect(self : ImDrawList*, a : Void*, b : Void*, col : LibC::UInt)
  fun imdrawlist_prim_rect_uv = ImDrawList_PrimRectUV(self : ImDrawList*, a : Void*, b : Void*, uv_a : Void*, uv_b : Void*, col : LibC::UInt)
  fun imdrawlist_prim_reserve = ImDrawList_PrimReserve(self : ImDrawList*, idx_count : LibC::Int, vtx_count : LibC::Int)
  fun imdrawlist_prim_vtx = ImDrawList_PrimVtx(self : ImDrawList*, pos : Void*, uv : Void*, col : LibC::UInt)
  fun imdrawlist_prim_write_idx = ImDrawList_PrimWriteIdx(self : ImDrawList*, idx : LibC::UShort)
  fun imdrawlist_prim_write_vtx = ImDrawList_PrimWriteVtx(self : ImDrawList*, pos : Void*, uv : Void*, col : LibC::UInt)
  fun imdrawlist_push_clip_rect = ImDrawList_PushClipRect(self : ImDrawList*, clip_rect_min : Void*, clip_rect_max : Void*, intersect_with_current_clip_rect : Bool)
  fun imdrawlist_push_clip_rect_full_screen = ImDrawList_PushClipRectFullScreen(self : ImDrawList*)
  fun imdrawlist_push_texture_id = ImDrawList_PushTextureID(self : ImDrawList*, texture_id : Void*)
  fun imdrawlist_update_clip_rect = ImDrawList_UpdateClipRect(self : ImDrawList*)
  fun imdrawlist_update_texture_id = ImDrawList_UpdateTextureID(self : ImDrawList*)
  fun imdrawlist_destroy = ImDrawList_destroy(self : ImDrawList*)

  struct ImDrawVert
    pos : Void*
    uv : Void*
    col : LibC::UInt
  end

  struct ImFont
    font_size : LibC::Float
    scale : LibC::Float
    display_offset : Void*
    glyphs : Void*
    index_advance_x : Void*
    index_lookup : Void*
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

  fun imfont_add_glyph = ImFont_AddGlyph(self : ImFont*, c : LibC::UShort, x0 : LibC::Float, y0 : LibC::Float, x1 : LibC::Float, y1 : LibC::Float, u0 : LibC::Float, v0 : LibC::Float, u1 : LibC::Float, v1 : LibC::Float, advance_x : LibC::Float)
  fun imfont_add_remap_char = ImFont_AddRemapChar(self : ImFont*, dst : LibC::UShort, src : LibC::UShort, overwrite_dst : Bool)
  fun imfont_build_lookup_table = ImFont_BuildLookupTable(self : ImFont*)
  fun imfont_calc_text_size_a = ImFont_CalcTextSizeA_nonUDT2(self : ImFont*, size : LibC::Float, max_width : LibC::Float, wrap_width : LibC::Float, text_begin : LibC::Char*, text_end : LibC::Char*, remaining : LibC::Char**) : Void*
  fun imfont_calc_word_wrap_position_a = ImFont_CalcWordWrapPositionA(self : ImFont*, scale : LibC::Float, text : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float) : LibC::Char*
  fun imfont_clear_output_data = ImFont_ClearOutputData(self : ImFont*)
  fun imfont_find_glyph = ImFont_FindGlyph(self : ImFont*, c : LibC::UShort) : ImFontGlyph*
  fun imfont_find_glyph_no_fallback = ImFont_FindGlyphNoFallback(self : ImFont*, c : LibC::UShort) : ImFontGlyph*
  fun imfont_get_char_advance = ImFont_GetCharAdvance(self : ImFont*, c : LibC::UShort) : LibC::Float
  fun imfont_get_debug_name = ImFont_GetDebugName(self : ImFont*) : LibC::Char*
  fun imfont_grow_index = ImFont_GrowIndex(self : ImFont*, new_size : LibC::Int)
  fun imfont_allocate = ImFont_ImFont : ImFont*
  fun imfont_is_loaded = ImFont_IsLoaded(self : ImFont*) : Bool
  fun imfont_render_char = ImFont_RenderChar(self : ImFont*, draw_list : ImDrawList*, size : LibC::Float, pos : Void*, col : LibC::UInt, c : LibC::UShort)
  fun imfont_render_text = ImFont_RenderText(self : ImFont*, draw_list : ImDrawList*, size : LibC::Float, pos : Void*, col : LibC::UInt, clip_rect : Void*, text_begin : LibC::Char*, text_end : LibC::Char*, wrap_width : LibC::Float, cpu_fine_clip : Bool)
  fun imfont_set_fallback_char = ImFont_SetFallbackChar(self : ImFont*, c : LibC::UShort)
  fun imfont_destroy = ImFont_destroy(self : ImFont*)

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
    tex_uv_scale : Void*
    tex_uv_white_pixel : Void*
    fonts : Void*
    custom_rects : Void*
    config_data : Void*
    custom_rect_ids : LibC::Int[1]
  end

  fun imfontatlas_add_custom_rect_font_glyph = ImFontAtlas_AddCustomRectFontGlyph(self : ImFontAtlas*, font : ImFont*, id : LibC::UShort, width : LibC::Int, height : LibC::Int, advance_x : LibC::Float, offset : Void*) : LibC::Int
  fun imfontatlas_add_custom_rect_regular = ImFontAtlas_AddCustomRectRegular(self : ImFontAtlas*, id : LibC::UInt, width : LibC::Int, height : LibC::Int) : LibC::Int
  fun imfontatlas_add_font = ImFontAtlas_AddFont(self : ImFontAtlas*, font_cfg : ImFontConfig*) : ImFont*
  fun imfontatlas_add_font_default = ImFontAtlas_AddFontDefault(self : ImFontAtlas*, font_cfg : ImFontConfig*) : ImFont*
  fun imfontatlas_add_font_from_file_ttf = ImFontAtlas_AddFontFromFileTTF(self : ImFontAtlas*, filename : LibC::Char*, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun imfontatlas_add_font_from_memory_compressed_base85_ttf = ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self : ImFontAtlas*, compressed_font_data_base85 : LibC::Char*, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun imfontatlas_add_font_from_memory_compressed_ttf = ImFontAtlas_AddFontFromMemoryCompressedTTF(self : ImFontAtlas*, compressed_font_data : Void*, compressed_font_size : LibC::Int, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun imfontatlas_add_font_from_memory_ttf = ImFontAtlas_AddFontFromMemoryTTF(self : ImFontAtlas*, font_data : Void*, font_size : LibC::Int, size_pixels : LibC::Float, font_cfg : ImFontConfig*, glyph_ranges : LibC::UShort*) : ImFont*
  fun imfontatlas_build = ImFontAtlas_Build(self : ImFontAtlas*) : Bool
  fun imfontatlas_calc_custom_rect_uv = ImFontAtlas_CalcCustomRectUV(self : ImFontAtlas*, rect : CustomRect*, out_uv_min : Void**, out_uv_max : Void**)
  fun imfontatlas_clear = ImFontAtlas_Clear(self : ImFontAtlas*)
  fun imfontatlas_clear_fonts = ImFontAtlas_ClearFonts(self : ImFontAtlas*)
  fun imfontatlas_clear_input_data = ImFontAtlas_ClearInputData(self : ImFontAtlas*)
  fun imfontatlas_clear_tex_data = ImFontAtlas_ClearTexData(self : ImFontAtlas*)
  fun imfontatlas_get_custom_rect_by_index = ImFontAtlas_GetCustomRectByIndex(self : ImFontAtlas*, index : LibC::Int) : CustomRect*
  fun imfontatlas_get_glyph_ranges_chinese_full = ImFontAtlas_GetGlyphRangesChineseFull(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_chinese_simplified_common = ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_cyrillic = ImFontAtlas_GetGlyphRangesCyrillic(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_default = ImFontAtlas_GetGlyphRangesDefault(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_japanese = ImFontAtlas_GetGlyphRangesJapanese(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_korean = ImFontAtlas_GetGlyphRangesKorean(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_glyph_ranges_thai = ImFontAtlas_GetGlyphRangesThai(self : ImFontAtlas*) : LibC::UShort*
  fun imfontatlas_get_mouse_cursor_tex_data = ImFontAtlas_GetMouseCursorTexData(self : ImFontAtlas*, cursor : ImGuiMouseCursor, out_offset : Void**, out_size : Void**, out_uv_border : Void**, out_uv_fill : Void**) : Bool
  fun imfontatlas_get_tex_data_as_alpha8 = ImFontAtlas_GetTexDataAsAlpha8(self : ImFontAtlas*, out_pixels : LibC::UChar**, out_width : LibC::Int*, out_height : LibC::Int*, out_bytes_per_pixel : LibC::Int*)
  fun imfontatlas_get_tex_data_as_rgba32 = ImFontAtlas_GetTexDataAsRGBA32(self : ImFontAtlas*, out_pixels : LibC::UChar**, out_width : LibC::Int*, out_height : LibC::Int*, out_bytes_per_pixel : LibC::Int*)
  fun imfontatlas_allocate = ImFontAtlas_ImFontAtlas : ImFontAtlas*
  fun imfontatlas_is_built = ImFontAtlas_IsBuilt(self : ImFontAtlas*) : Bool
  fun imfontatlas_set_tex_id = ImFontAtlas_SetTexID(self : ImFontAtlas*, id : Void*)
  fun imfontatlas_destroy = ImFontAtlas_destroy(self : ImFontAtlas*)

  struct ImFontConfig
    font_data : Void*
    font_data_size : LibC::Int
    font_data_owned_by_atlas : Bool
    font_no : LibC::Int
    size_pixels : LibC::Float
    oversample_h : LibC::Int
    oversample_v : LibC::Int
    pixel_snap_h : Bool
    glyph_extra_spacing : Void*
    glyph_offset : Void*
    glyph_ranges : LibC::UShort*
    glyph_min_advance_x : LibC::Float
    glyph_max_advance_x : LibC::Float
    merge_mode : Bool
    rasterizer_flags : LibC::UInt
    rasterizer_multiply : LibC::Float
    name : LibC::Char[40]
    dst_font : ImFont*
  end

  fun imfontconfig_allocate = ImFontConfig_ImFontConfig : ImFontConfig*
  fun imfontconfig_destroy = ImFontConfig_destroy(self : ImFontConfig*)

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
    used_chars : Void*
  end

  fun imfontglyphrangesbuilder_add_char = ImFontGlyphRangesBuilder_AddChar(self : ImFontGlyphRangesBuilder*, c : LibC::UShort)
  fun imfontglyphrangesbuilder_add_ranges = ImFontGlyphRangesBuilder_AddRanges(self : ImFontGlyphRangesBuilder*, ranges : LibC::UShort*)
  fun imfontglyphrangesbuilder_add_text = ImFontGlyphRangesBuilder_AddText(self : ImFontGlyphRangesBuilder*, text : LibC::Char*, text_end : LibC::Char*)
  fun imfontglyphrangesbuilder_build_ranges = ImFontGlyphRangesBuilder_BuildRanges(self : ImFontGlyphRangesBuilder*, out_ranges : Void**)
  fun imfontglyphrangesbuilder_get_bit = ImFontGlyphRangesBuilder_GetBit(self : ImFontGlyphRangesBuilder*, n : LibC::Int) : Bool
  fun imfontglyphrangesbuilder_allocate = ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder : ImFontGlyphRangesBuilder*
  fun imfontglyphrangesbuilder_set_bit = ImFontGlyphRangesBuilder_SetBit(self : ImFontGlyphRangesBuilder*, n : LibC::Int)
  fun imfontglyphrangesbuilder_destroy = ImFontGlyphRangesBuilder_destroy(self : ImFontGlyphRangesBuilder*)

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
    display_framebuffer_scale : Void*
    display_visible_min : Void*
    display_visible_max : Void*
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
    mouse_pos : Void*
    mouse_down : Bool[5]
    mouse_wheel : LibC::Float
    mouse_wheel_h : LibC::Float
    key_ctrl : Bool
    key_shift : Bool
    key_alt : Bool
    key_super : Bool
    keys_down : Bool[512]
    nav_inputs : LibC::Float[21]
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
    mouse_delta : Void*
    mouse_pos_prev : Void*
    mouse_clicked_pos : Void*[5]
    mouse_clicked_time : LibC::Double[5]
    mouse_clicked : Bool[5]
    mouse_double_clicked : Bool[5]
    mouse_released : Bool[5]
    mouse_down_owned : Bool[5]
    mouse_down_duration : LibC::Float[5]
    mouse_down_duration_prev : LibC::Float[5]
    mouse_drag_max_distance_abs : Void*[5]
    mouse_drag_max_distance_sqr : LibC::Float[5]
    keys_down_duration : LibC::Float[512]
    keys_down_duration_prev : LibC::Float[512]
    nav_inputs_down_duration : LibC::Float[21]
    nav_inputs_down_duration_prev : LibC::Float[21]
    input_queue_characters : Void*
  end

  fun imguiio_add_input_character = ImGuiIO_AddInputCharacter(self : ImGuiIO*, c : LibC::UShort)
  fun imguiio_add_input_characters_utf8 = ImGuiIO_AddInputCharactersUTF8(self : ImGuiIO*, str : LibC::Char*)
  fun imguiio_clear_input_characters = ImGuiIO_ClearInputCharacters(self : ImGuiIO*)
  fun imguiio_allocate = ImGuiIO_ImGuiIO : ImGuiIO*
  fun imguiio_destroy = ImGuiIO_destroy(self : ImGuiIO*)

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

  fun imguiinputtextcallbackdata_delete_chars = ImGuiInputTextCallbackData_DeleteChars(self : ImGuiInputTextCallbackData*, pos : LibC::Int, bytes_count : LibC::Int)
  fun imguiinputtextcallbackdata_has_selection = ImGuiInputTextCallbackData_HasSelection(self : ImGuiInputTextCallbackData*) : Bool
  fun imguiinputtextcallbackdata_allocate = ImGuiInputTextCallbackData_ImGuiInputTextCallbackData : ImGuiInputTextCallbackData*
  fun imguiinputtextcallbackdata_insert_chars = ImGuiInputTextCallbackData_InsertChars(self : ImGuiInputTextCallbackData*, pos : LibC::Int, text : LibC::Char*, text_end : LibC::Char*)
  fun imguiinputtextcallbackdata_destroy = ImGuiInputTextCallbackData_destroy(self : ImGuiInputTextCallbackData*)

  struct ImGuiListClipper
    start_pos_y : LibC::Float
    items_height : LibC::Float
    items_count : LibC::Int
    step_no : LibC::Int
    display_start : LibC::Int
    display_end : LibC::Int
  end

  fun imguilistclipper_begin = ImGuiListClipper_Begin(self : ImGuiListClipper*, items_count : LibC::Int, items_height : LibC::Float)
  fun imguilistclipper_end = ImGuiListClipper_End(self : ImGuiListClipper*)
  fun imguilistclipper_allocate = ImGuiListClipper_ImGuiListClipper(items_count : LibC::Int, items_height : LibC::Float) : ImGuiListClipper*
  fun imguilistclipper_step = ImGuiListClipper_Step(self : ImGuiListClipper*) : Bool
  fun imguilistclipper_destroy = ImGuiListClipper_destroy(self : ImGuiListClipper*)

  struct ImGuiOnceUponAFrame
    ref_frame : LibC::Int
  end

  fun imguionceuponaframe_allocate = ImGuiOnceUponAFrame_ImGuiOnceUponAFrame : ImGuiOnceUponAFrame*
  fun imguionceuponaframe_destroy = ImGuiOnceUponAFrame_destroy(self : ImGuiOnceUponAFrame*)

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

  fun imguipayload_clear = ImGuiPayload_Clear(self : ImGuiPayload*)
  fun imguipayload_allocate = ImGuiPayload_ImGuiPayload : ImGuiPayload*
  fun imguipayload_is_data_type = ImGuiPayload_IsDataType(self : ImGuiPayload*, type : LibC::Char*) : Bool
  fun imguipayload_is_delivery = ImGuiPayload_IsDelivery(self : ImGuiPayload*) : Bool
  fun imguipayload_is_preview = ImGuiPayload_IsPreview(self : ImGuiPayload*) : Bool
  fun imguipayload_destroy = ImGuiPayload_destroy(self : ImGuiPayload*)

  struct ImGuiSizeCallbackData
    user_data : Void*
    pos : Void*
    current_size : Void*
    desired_size : Void*
  end

  struct ImGuiStorage
    data : Void*
  end

  fun imguistorage_build_sort_by_key = ImGuiStorage_BuildSortByKey(self : ImGuiStorage*)
  fun imguistorage_clear = ImGuiStorage_Clear(self : ImGuiStorage*)
  fun imguistorage_get_bool = ImGuiStorage_GetBool(self : ImGuiStorage*, key : LibC::UInt, default_val : Bool) : Bool
  fun imguistorage_get_bool_ref = ImGuiStorage_GetBoolRef(self : ImGuiStorage*, key : LibC::UInt, default_val : Bool) : Bool*
  fun imguistorage_get_float = ImGuiStorage_GetFloat(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Float) : LibC::Float
  fun imguistorage_get_float_ref = ImGuiStorage_GetFloatRef(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Float) : LibC::Float*
  fun imguistorage_get_int = ImGuiStorage_GetInt(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Int) : LibC::Int
  fun imguistorage_get_int_ref = ImGuiStorage_GetIntRef(self : ImGuiStorage*, key : LibC::UInt, default_val : LibC::Int) : LibC::Int*
  fun imguistorage_get_void_ptr = ImGuiStorage_GetVoidPtr(self : ImGuiStorage*, key : LibC::UInt) : Void*
  fun imguistorage_get_void_ptr_ref = ImGuiStorage_GetVoidPtrRef(self : ImGuiStorage*, key : LibC::UInt, default_val : Void*) : Void**
  fun imguistorage_set_all_int = ImGuiStorage_SetAllInt(self : ImGuiStorage*, val : LibC::Int)
  fun imguistorage_set_bool = ImGuiStorage_SetBool(self : ImGuiStorage*, key : LibC::UInt, val : Bool)
  fun imguistorage_set_float = ImGuiStorage_SetFloat(self : ImGuiStorage*, key : LibC::UInt, val : LibC::Float)
  fun imguistorage_set_int = ImGuiStorage_SetInt(self : ImGuiStorage*, key : LibC::UInt, val : LibC::Int)
  fun imguistorage_set_void_ptr = ImGuiStorage_SetVoidPtr(self : ImGuiStorage*, key : LibC::UInt, val : Void*)

  struct ImGuiStyle
    alpha : LibC::Float
    window_padding : Void*
    window_rounding : LibC::Float
    window_border_size : LibC::Float
    window_min_size : Void*
    window_title_align : Void*
    child_rounding : LibC::Float
    child_border_size : LibC::Float
    popup_rounding : LibC::Float
    popup_border_size : LibC::Float
    frame_padding : Void*
    frame_rounding : LibC::Float
    frame_border_size : LibC::Float
    item_spacing : Void*
    item_inner_spacing : Void*
    touch_extra_padding : Void*
    indent_spacing : LibC::Float
    columns_min_spacing : LibC::Float
    scrollbar_size : LibC::Float
    scrollbar_rounding : LibC::Float
    grab_min_size : LibC::Float
    grab_rounding : LibC::Float
    tab_rounding : LibC::Float
    tab_border_size : LibC::Float
    button_text_align : Void*
    display_window_padding : Void*
    display_safe_area_padding : Void*
    mouse_cursor_scale : LibC::Float
    anti_aliased_lines : Bool
    anti_aliased_fill : Bool
    curve_tessellation_tol : LibC::Float
    colors : Void*[48]
  end

  fun imguistyle_allocate = ImGuiStyle_ImGuiStyle : ImGuiStyle*
  fun imguistyle_scale_all_sizes = ImGuiStyle_ScaleAllSizes(self : ImGuiStyle*, scale_factor : LibC::Float)
  fun imguistyle_destroy = ImGuiStyle_destroy(self : ImGuiStyle*)

  struct ImGuiTextBuffer
    buf : Void*
  end

  fun imguitextbuffer_allocate = ImGuiTextBuffer_ImGuiTextBuffer : ImGuiTextBuffer*
  fun imguitextbuffer_appendf = ImGuiTextBuffer_appendf(self : ImGuiTextBuffer*, fmt : LibC::Char*)
  fun imguitextbuffer_begin = ImGuiTextBuffer_begin(self : ImGuiTextBuffer*) : LibC::Char*
  fun imguitextbuffer_c_str = ImGuiTextBuffer_c_str(self : ImGuiTextBuffer*) : LibC::Char*
  fun imguitextbuffer_clear = ImGuiTextBuffer_clear(self : ImGuiTextBuffer*)
  fun imguitextbuffer_destroy = ImGuiTextBuffer_destroy(self : ImGuiTextBuffer*)
  fun imguitextbuffer_empty = ImGuiTextBuffer_empty(self : ImGuiTextBuffer*) : Bool
  fun imguitextbuffer_end = ImGuiTextBuffer_end(self : ImGuiTextBuffer*) : LibC::Char*
  fun imguitextbuffer_reserve = ImGuiTextBuffer_reserve(self : ImGuiTextBuffer*, capacity : LibC::Int)
  fun imguitextbuffer_size = ImGuiTextBuffer_size(self : ImGuiTextBuffer*) : LibC::Int

  struct ImGuiTextFilter
    input_buf : LibC::Char[256]
    filters : Void*
    count_grep : LibC::Int
  end

  fun imguitextfilter_build = ImGuiTextFilter_Build(self : ImGuiTextFilter*)
  fun imguitextfilter_clear = ImGuiTextFilter_Clear(self : ImGuiTextFilter*)
  fun imguitextfilter_draw = ImGuiTextFilter_Draw(self : ImGuiTextFilter*, label : LibC::Char*, width : LibC::Float) : Bool
  fun imguitextfilter_allocate = ImGuiTextFilter_ImGuiTextFilter(default_filter : LibC::Char*) : ImGuiTextFilter*
  fun imguitextfilter_is_active = ImGuiTextFilter_IsActive(self : ImGuiTextFilter*) : Bool
  fun imguitextfilter_pass_filter = ImGuiTextFilter_PassFilter(self : ImGuiTextFilter*, text : LibC::Char*, text_end : LibC::Char*) : Bool
  fun imguitextfilter_destroy = ImGuiTextFilter_destroy(self : ImGuiTextFilter*)

  struct TextRange
    b : LibC::Char*
    e : LibC::Char*
  end

  fun textrange_allocate = TextRange_TextRange : TextRange*
  fun textrange_allocate = TextRange_TextRangeStr(_b : LibC::Char*, _e : LibC::Char*) : TextRange*
  fun textrange_begin = TextRange_begin(self : TextRange*) : LibC::Char*
  fun textrange_destroy = TextRange_destroy(self : TextRange*)
  fun textrange_empty = TextRange_empty(self : TextRange*) : Bool
  fun textrange_end = TextRange_end(self : TextRange*) : LibC::Char*
  fun textrange_split = TextRange_split(self : TextRange*, separator : LibC::Char, out : Void**)
end
