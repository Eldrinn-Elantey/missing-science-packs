local styles = data.raw["gui-style"]["default"]

-- Makes room under the vanilla research bar for the missing pack row.
styles.current_research_info_button.bottom_padding = 4 + 20

styles.msp_root_frame = {
  type = "frame_style",
  parent = "invisible_frame",
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    horizontal_align = "right",
    horizontally_stretchable = "on",
  },
}

styles.msp_panel_frame = {
  type = "frame_style",
  parent = "invisible_frame",
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    horizontal_align = "left",
  },
}
