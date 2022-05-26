@_exported import SwiftLexicon // From https://github.com/screensailor/Lexicon
import Foundation

public let app = L_app("app")

public final class L_app: L, I_app {
	public override class var localized: String { NSLocalizedString("app", comment: "") }
}
public protocol I_app: I {}
public extension I_app {
	var `did`: L_app_did { .init("\(__).did") }
	var `document`: L_app_document { .init("\(__).document") }
	var `menu`: L_app_menu { .init("\(__).menu") }
	var `ui`: L_app_ui { .init("\(__).ui") }
}
public final class L_app_did: L, I_app_did {
	public override class var localized: String { NSLocalizedString("app.did", comment: "") }
}
public protocol I_app_did: I {}
public extension I_app_did {
	var `launch`: L_app_did_launch { .init("\(__).launch") }
}
public final class L_app_did_launch: L, I_app_did_launch {
	public override class var localized: String { NSLocalizedString("app.did.launch", comment: "") }
}
public protocol I_app_did_launch: I {}
public final class L_app_document: L, I_app_document {
	public override class var localized: String { NSLocalizedString("app.document", comment: "") }
}
public protocol I_app_document: I {}
public extension I_app_document {
	var `browser`: L_app_document_browser { .init("\(__).browser") }
	var `editor`: L_app_document_editor { .init("\(__).editor") }
	var `lexicon`: L_app_document_lexicon { .init("\(__).lexicon") }
	var `view`: L_app_document_view { .init("\(__).view") }
}
public final class L_app_document_browser: L, I_app_document_browser {
	public override class var localized: String { NSLocalizedString("app.document.browser", comment: "") }
}
public protocol I_app_document_browser: I {}
public extension I_app_document_browser {
	var `cli`: L_app_document_browser_cli { .init("\(__).cli") }
	var `column`: L_app_document_browser_column { .init("\(__).column") }
	var `view`: L_app_document_browser_view { .init("\(__).view") }
}
public final class L_app_document_browser_cli: L, I_app_document_browser_cli {
	public override class var localized: String { NSLocalizedString("app.document.browser.cli", comment: "") }
}
public protocol I_app_document_browser_cli: I_app_ui_cli {}
public final class L_app_document_browser_column: L, I_app_document_browser_column {
	public override class var localized: String { NSLocalizedString("app.document.browser.column", comment: "") }
}
public protocol I_app_document_browser_column: I {}
public extension I_app_document_browser_column {
	var `cell`: L_app_document_browser_column_cell { .init("\(__).cell") }
	var `section`: L_app_document_browser_column_section { .init("\(__).section") }
}
public final class L_app_document_browser_column_cell: L, I_app_document_browser_column_cell {
	public override class var localized: String { NSLocalizedString("app.document.browser.column.cell", comment: "") }
}
public protocol I_app_document_browser_column_cell: I_app_ui_control {}
public final class L_app_document_browser_column_section: L, I_app_document_browser_column_section {
	public override class var localized: String { NSLocalizedString("app.document.browser.column.section", comment: "") }
}
public protocol I_app_document_browser_column_section: I {}
public extension I_app_document_browser_column_section {
	var `heading`: L_app_document_browser_column_section_heading { .init("\(__).heading") }
}
public final class L_app_document_browser_column_section_heading: L, I_app_document_browser_column_section_heading {
	public override class var localized: String { NSLocalizedString("app.document.browser.column.section.heading", comment: "") }
}
public protocol I_app_document_browser_column_section_heading: I_app_ui_control {}
public final class L_app_document_browser_view: L, I_app_document_browser_view {
	public override class var localized: String { NSLocalizedString("app.document.browser.view", comment: "") }
}
public protocol I_app_document_browser_view: I_app_ui_view {}
public final class L_app_document_editor: L, I_app_document_editor {
	public override class var localized: String { NSLocalizedString("app.document.editor", comment: "") }
}
public protocol I_app_document_editor: I_app_document_browser {}
public extension I_app_document_editor {
	var `search`: L_app_document_editor_search { .init("\(__).search") }
	var `show`: L_app_document_editor_show { .init("\(__).show") }
}
public final class L_app_document_editor_search: L, I_app_document_editor_search {
	public override class var localized: String { NSLocalizedString("app.document.editor.search", comment: "") }
}
public protocol I_app_document_editor_search: I_app_ui_search {}
public final class L_app_document_editor_show: L, I_app_document_editor_show {
	public override class var localized: String { NSLocalizedString("app.document.editor.show", comment: "") }
}
public protocol I_app_document_editor_show: I {}
public extension I_app_document_editor_show {
	var `stats`: L_app_document_editor_show_stats { .init("\(__).stats") }
}
public final class L_app_document_editor_show_stats: L, I_app_document_editor_show_stats {
	public override class var localized: String { NSLocalizedString("app.document.editor.show.stats", comment: "") }
}
public protocol I_app_document_editor_show_stats: I {}
public final class L_app_document_lexicon: L, I_app_document_lexicon {
	public override class var localized: String { NSLocalizedString("app.document.lexicon", comment: "") }
}
public protocol I_app_document_lexicon: I {}
public extension I_app_document_lexicon {
	var `graph`: L_app_document_lexicon_graph { .init("\(__).graph") }
}
public final class L_app_document_lexicon_graph: L, I_app_document_lexicon_graph {
	public override class var localized: String { NSLocalizedString("app.document.lexicon.graph", comment: "") }
}
public protocol I_app_document_lexicon_graph: I {}
public extension I_app_document_lexicon_graph {
	var `did`: L_app_document_lexicon_graph_did { .init("\(__).did") }
}
public final class L_app_document_lexicon_graph_did: L, I_app_document_lexicon_graph_did {
	public override class var localized: String { NSLocalizedString("app.document.lexicon.graph.did", comment: "") }
}
public protocol I_app_document_lexicon_graph_did: I {}
public extension I_app_document_lexicon_graph_did {
	var `change`: L_app_document_lexicon_graph_did_change { .init("\(__).change") }
	var `load`: L_app_document_lexicon_graph_did_load { .init("\(__).load") }
}
public final class L_app_document_lexicon_graph_did_change: L, I_app_document_lexicon_graph_did_change {
	public override class var localized: String { NSLocalizedString("app.document.lexicon.graph.did.change", comment: "") }
}
public protocol I_app_document_lexicon_graph_did_change: I {}
public final class L_app_document_lexicon_graph_did_load: L, I_app_document_lexicon_graph_did_load {
	public override class var localized: String { NSLocalizedString("app.document.lexicon.graph.did.load", comment: "") }
}
public protocol I_app_document_lexicon_graph_did_load: I {}
public final class L_app_document_view: L, I_app_document_view {
	public override class var localized: String { NSLocalizedString("app.document.view", comment: "") }
}
public protocol I_app_document_view: I_app_ui_view {}
public final class L_app_menu: L, I_app_menu {
	public override class var localized: String { NSLocalizedString("app.menu", comment: "") }
}
public protocol I_app_menu: I {}
public extension I_app_menu {
	var `edit`: L_app_menu_edit { .init("\(__).edit") }
	var `file`: L_app_menu_file { .init("\(__).file") }
	var `view`: L_app_menu_view { .init("\(__).view") }
}
public final class L_app_menu_edit: L, I_app_menu_edit {
	public override class var localized: String { NSLocalizedString("app.menu.edit", comment: "") }
}
public protocol I_app_menu_edit: I {}
public extension I_app_menu_edit {
	var `cancel`: L_app_menu_edit_cancel { .init("\(__).cancel") }
	var `commit`: L_app_menu_edit_commit { .init("\(__).commit") }
	var `copy`: L_app_menu_edit_copy { .init("\(__).copy") }
	var `cut`: L_app_menu_edit_cut { .init("\(__).cut") }
	var `find`: L_app_menu_edit_find { .init("\(__).find") }
	var `inherit`: L_app_menu_edit_inherit { .init("\(__).inherit") }
	var `paste`: L_app_menu_edit_paste { .init("\(__).paste") }
	var `recording`: L_app_menu_edit_recording { .init("\(__).recording") }
	var `rename`: L_app_menu_edit_rename { .init("\(__).rename") }
	var `synonym`: L_app_menu_edit_synonym { .init("\(__).synonym") }
}
public final class L_app_menu_edit_cancel: L, I_app_menu_edit_cancel {
	public override class var localized: String { NSLocalizedString("app.menu.edit.cancel", comment: "") }
}
public protocol I_app_menu_edit_cancel: I {}
public final class L_app_menu_edit_commit: L, I_app_menu_edit_commit {
	public override class var localized: String { NSLocalizedString("app.menu.edit.commit", comment: "") }
}
public protocol I_app_menu_edit_commit: I {}
public extension I_app_menu_edit_commit {
	var `and`: L_app_menu_edit_commit_and { .init("\(__).and") }
}
public final class L_app_menu_edit_commit_and: L, I_app_menu_edit_commit_and {
	public override class var localized: String { NSLocalizedString("app.menu.edit.commit.and", comment: "") }
}
public protocol I_app_menu_edit_commit_and: I {}
public extension I_app_menu_edit_commit_and {
	var `enter`: L_app_menu_edit_commit_and_enter { .init("\(__).enter") }
}
public final class L_app_menu_edit_commit_and_enter: L, I_app_menu_edit_commit_and_enter {
	public override class var localized: String { NSLocalizedString("app.menu.edit.commit.and.enter", comment: "") }
}
public protocol I_app_menu_edit_commit_and_enter: I {}
public final class L_app_menu_edit_copy: L, I_app_menu_edit_copy {
	public override class var localized: String { NSLocalizedString("app.menu.edit.copy", comment: "") }
}
public protocol I_app_menu_edit_copy: I {}
public extension I_app_menu_edit_copy {
	var `lemma`: L_app_menu_edit_copy_lemma { .init("\(__).lemma") }
	var `lexicon`: L_app_menu_edit_copy_lexicon { .init("\(__).lexicon") }
}
public final class L_app_menu_edit_copy_lemma: L, I_app_menu_edit_copy_lemma {
	public override class var localized: String { NSLocalizedString("app.menu.edit.copy.lemma", comment: "") }
}
public protocol I_app_menu_edit_copy_lemma: I {}
public final class L_app_menu_edit_copy_lexicon: L, I_app_menu_edit_copy_lexicon {
	public override class var localized: String { NSLocalizedString("app.menu.edit.copy.lexicon", comment: "") }
}
public protocol I_app_menu_edit_copy_lexicon: I {}
public final class L_app_menu_edit_cut: L, I_app_menu_edit_cut {
	public override class var localized: String { NSLocalizedString("app.menu.edit.cut", comment: "") }
}
public protocol I_app_menu_edit_cut: I {}
public final class L_app_menu_edit_find: L, I_app_menu_edit_find {
	public override class var localized: String { NSLocalizedString("app.menu.edit.find", comment: "") }
}
public protocol I_app_menu_edit_find: I {}
public final class L_app_menu_edit_inherit: L, I_app_menu_edit_inherit {
	public override class var localized: String { NSLocalizedString("app.menu.edit.inherit", comment: "") }
}
public protocol I_app_menu_edit_inherit: I {}
public final class L_app_menu_edit_paste: L, I_app_menu_edit_paste {
	public override class var localized: String { NSLocalizedString("app.menu.edit.paste", comment: "") }
}
public protocol I_app_menu_edit_paste: I {}
public extension I_app_menu_edit_paste {
	var `default`: L_app_menu_edit_paste_default { .init("\(__).default") }
	var `sentences`: L_app_menu_edit_paste_sentences { .init("\(__).sentences") }
}
public final class L_app_menu_edit_paste_default: L, I_app_menu_edit_paste_default {
	public override class var localized: String { NSLocalizedString("app.menu.edit.paste.default", comment: "") }
}
public protocol I_app_menu_edit_paste_default: I {}
public final class L_app_menu_edit_paste_sentences: L, I_app_menu_edit_paste_sentences {
	public override class var localized: String { NSLocalizedString("app.menu.edit.paste.sentences", comment: "") }
}
public protocol I_app_menu_edit_paste_sentences: I {}
public final class L_app_menu_edit_recording: L, I_app_menu_edit_recording {
	public override class var localized: String { NSLocalizedString("app.menu.edit.recording", comment: "") }
}
public protocol I_app_menu_edit_recording: I {}
public extension I_app_menu_edit_recording {
	var `start`: L_app_menu_edit_recording_start { .init("\(__).start") }
	var `stop`: L_app_menu_edit_recording_stop { .init("\(__).stop") }
}
public final class L_app_menu_edit_recording_start: L, I_app_menu_edit_recording_start {
	public override class var localized: String { NSLocalizedString("app.menu.edit.recording.start", comment: "") }
}
public protocol I_app_menu_edit_recording_start: I {}
public final class L_app_menu_edit_recording_stop: L, I_app_menu_edit_recording_stop {
	public override class var localized: String { NSLocalizedString("app.menu.edit.recording.stop", comment: "") }
}
public protocol I_app_menu_edit_recording_stop: I {}
public final class L_app_menu_edit_rename: L, I_app_menu_edit_rename {
	public override class var localized: String { NSLocalizedString("app.menu.edit.rename", comment: "") }
}
public protocol I_app_menu_edit_rename: I {}
public final class L_app_menu_edit_synonym: L, I_app_menu_edit_synonym {
	public override class var localized: String { NSLocalizedString("app.menu.edit.synonym", comment: "") }
}
public protocol I_app_menu_edit_synonym: I {}
public extension I_app_menu_edit_synonym {
	var `find`: L_app_menu_edit_synonym_find { .init("\(__).find") }
}
public final class L_app_menu_edit_synonym_find: L, I_app_menu_edit_synonym_find {
	public override class var localized: String { NSLocalizedString("app.menu.edit.synonym.find", comment: "") }
}
public protocol I_app_menu_edit_synonym_find: I {}
public final class L_app_menu_file: L, I_app_menu_file {
	public override class var localized: String { NSLocalizedString("app.menu.file", comment: "") }
}
public protocol I_app_menu_file: I {}
public extension I_app_menu_file {
	var `export`: L_app_menu_file_export { .init("\(__).export") }
}
public final class L_app_menu_file_export: L, I_app_menu_file_export {
	public override class var localized: String { NSLocalizedString("app.menu.file.export", comment: "") }
}
public protocol I_app_menu_file_export: I {}
public extension I_app_menu_file_export {
	var `json`: L_app_menu_file_export_json { .init("\(__).json") }
	var `recording`: L_app_menu_file_export_recording { .init("\(__).recording") }
	var `swift`: L_app_menu_file_export_swift { .init("\(__).swift") }
}
public final class L_app_menu_file_export_json: L, I_app_menu_file_export_json {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.json", comment: "") }
}
public protocol I_app_menu_file_export_json: I {}
public extension I_app_menu_file_export_json {
	var `classes`: L_app_menu_file_export_json_classes { .init("\(__).classes") }
}
public final class L_app_menu_file_export_json_classes: L, I_app_menu_file_export_json_classes {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.json.classes", comment: "") }
}
public protocol I_app_menu_file_export_json_classes: I {}
public final class L_app_menu_file_export_recording: L, I_app_menu_file_export_recording {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.recording", comment: "") }
}
public protocol I_app_menu_file_export_recording: I {}
public final class L_app_menu_file_export_swift: L, I_app_menu_file_export_swift {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.swift", comment: "") }
}
public protocol I_app_menu_file_export_swift: I {}
public extension I_app_menu_file_export_swift {
	var `classes`: L_app_menu_file_export_swift_classes { .init("\(__).classes") }
}
public final class L_app_menu_file_export_swift_classes: L, I_app_menu_file_export_swift_classes {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.swift.classes", comment: "") }
}
public protocol I_app_menu_file_export_swift_classes: I {}
public extension I_app_menu_file_export_swift_classes {
	var `and`: L_app_menu_file_export_swift_classes_and { .init("\(__).and") }
}
public final class L_app_menu_file_export_swift_classes_and: L, I_app_menu_file_export_swift_classes_and {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.swift.classes.and", comment: "") }
}
public protocol I_app_menu_file_export_swift_classes_and: I {}
public extension I_app_menu_file_export_swift_classes_and {
	var `protocols`: L_app_menu_file_export_swift_classes_and_protocols { .init("\(__).protocols") }
}
public final class L_app_menu_file_export_swift_classes_and_protocols: L, I_app_menu_file_export_swift_classes_and_protocols {
	public override class var localized: String { NSLocalizedString("app.menu.file.export.swift.classes.and.protocols", comment: "") }
}
public protocol I_app_menu_file_export_swift_classes_and_protocols: I {}
public final class L_app_menu_view: L, I_app_menu_view {
	public override class var localized: String { NSLocalizedString("app.menu.view", comment: "") }
}
public protocol I_app_menu_view: I {}
public extension I_app_menu_view {
	var `back`: L_app_menu_view_back { .init("\(__).back") }
	var `forward`: L_app_menu_view_forward { .init("\(__).forward") }
	var `stats`: L_app_menu_view_stats { .init("\(__).stats") }
	var `theme`: L_app_menu_view_theme { .init("\(__).theme") }
}
public final class L_app_menu_view_back: L, I_app_menu_view_back {
	public override class var localized: String { NSLocalizedString("app.menu.view.back", comment: "") }
}
public protocol I_app_menu_view_back: I {}
public final class L_app_menu_view_forward: L, I_app_menu_view_forward {
	public override class var localized: String { NSLocalizedString("app.menu.view.forward", comment: "") }
}
public protocol I_app_menu_view_forward: I {}
public final class L_app_menu_view_stats: L, I_app_menu_view_stats {
	public override class var localized: String { NSLocalizedString("app.menu.view.stats", comment: "") }
}
public protocol I_app_menu_view_stats: I {}
public final class L_app_menu_view_theme: L, I_app_menu_view_theme {
	public override class var localized: String { NSLocalizedString("app.menu.view.theme", comment: "") }
}
public protocol I_app_menu_view_theme: I {}
public extension I_app_menu_view_theme {
	var `toggle`: L_app_menu_view_theme_toggle { .init("\(__).toggle") }
}
public final class L_app_menu_view_theme_toggle: L, I_app_menu_view_theme_toggle {
	public override class var localized: String { NSLocalizedString("app.menu.view.theme.toggle", comment: "") }
}
public protocol I_app_menu_view_theme_toggle: I {}
public final class L_app_ui: L, I_app_ui {
	public override class var localized: String { NSLocalizedString("app.ui", comment: "") }
}
public protocol I_app_ui: I {}
public extension I_app_ui {
	var `cli`: L_app_ui_cli { .init("\(__).cli") }
	var `control`: L_app_ui_control { .init("\(__).control") }
	var `search`: L_app_ui_search { .init("\(__).search") }
	var `view`: L_app_ui_view { .init("\(__).view") }
}
public final class L_app_ui_cli: L, I_app_ui_cli {
	public override class var localized: String { NSLocalizedString("app.ui.cli", comment: "") }
}
public protocol I_app_ui_cli: I {}
public extension I_app_ui_cli {
	var `append`: L_app_ui_cli_append { .init("\(__).append") }
	var `backspace`: L_app_ui_cli_backspace { .init("\(__).backspace") }
	var `commit`: L_app_ui_cli_commit { .init("\(__).commit") }
	var `did`: L_app_ui_cli_did { .init("\(__).did") }
	var `enter`: L_app_ui_cli_enter { .init("\(__).enter") }
	var `lemma`: L_app_ui_cli_lemma { .init("\(__).lemma") }
	var `reset`: L_app_ui_cli_reset { .init("\(__).reset") }
	var `select`: L_app_ui_cli_select { .init("\(__).select") }
}
public final class L_app_ui_cli_append: L, I_app_ui_cli_append {
	public override class var localized: String { NSLocalizedString("app.ui.cli.append", comment: "") }
}
public protocol I_app_ui_cli_append: I {}
public final class L_app_ui_cli_backspace: L, I_app_ui_cli_backspace {
	public override class var localized: String { NSLocalizedString("app.ui.cli.backspace", comment: "") }
}
public protocol I_app_ui_cli_backspace: I {}
public final class L_app_ui_cli_commit: L, I_app_ui_cli_commit {
	public override class var localized: String { NSLocalizedString("app.ui.cli.commit", comment: "") }
}
public protocol I_app_ui_cli_commit: I {}
public final class L_app_ui_cli_did: L, I_app_ui_cli_did {
	public override class var localized: String { NSLocalizedString("app.ui.cli.did", comment: "") }
}
public protocol I_app_ui_cli_did: I {}
public extension I_app_ui_cli_did {
	var `change`: L_app_ui_cli_did_change { .init("\(__).change") }
}
public final class L_app_ui_cli_did_change: L, I_app_ui_cli_did_change {
	public override class var localized: String { NSLocalizedString("app.ui.cli.did.change", comment: "") }
}
public protocol I_app_ui_cli_did_change: I {}
public final class L_app_ui_cli_enter: L, I_app_ui_cli_enter {
	public override class var localized: String { NSLocalizedString("app.ui.cli.enter", comment: "") }
}
public protocol I_app_ui_cli_enter: I {}
public final class L_app_ui_cli_lemma: L, I_app_ui_cli_lemma {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma", comment: "") }
}
public protocol I_app_ui_cli_lemma: I {}
public extension I_app_ui_cli_lemma {
	var `add`: L_app_ui_cli_lemma_add { .init("\(__).add") }
	var `delete`: L_app_ui_cli_lemma_delete { .init("\(__).delete") }
	var `remove`: L_app_ui_cli_lemma_remove { .init("\(__).remove") }
	var `rename`: L_app_ui_cli_lemma_rename { .init("\(__).rename") }
}
public final class L_app_ui_cli_lemma_add: L, I_app_ui_cli_lemma_add {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.add", comment: "") }
}
public protocol I_app_ui_cli_lemma_add: I {}
public extension I_app_ui_cli_lemma_add {
	var `inheritance`: L_app_ui_cli_lemma_add_inheritance { .init("\(__).inheritance") }
	var `protonym`: L_app_ui_cli_lemma_add_protonym { .init("\(__).protonym") }
}
public final class L_app_ui_cli_lemma_add_inheritance: L, I_app_ui_cli_lemma_add_inheritance {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.add.inheritance", comment: "") }
}
public protocol I_app_ui_cli_lemma_add_inheritance: I {}
public final class L_app_ui_cli_lemma_add_protonym: L, I_app_ui_cli_lemma_add_protonym {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.add.protonym", comment: "") }
}
public protocol I_app_ui_cli_lemma_add_protonym: I {}
public final class L_app_ui_cli_lemma_delete: L, I_app_ui_cli_lemma_delete {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.delete", comment: "") }
}
public protocol I_app_ui_cli_lemma_delete: I {}
public final class L_app_ui_cli_lemma_remove: L, I_app_ui_cli_lemma_remove {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.remove", comment: "") }
}
public protocol I_app_ui_cli_lemma_remove: I {}
public extension I_app_ui_cli_lemma_remove {
	var `inheritance`: L_app_ui_cli_lemma_remove_inheritance { .init("\(__).inheritance") }
	var `protonym`: L_app_ui_cli_lemma_remove_protonym { .init("\(__).protonym") }
}
public final class L_app_ui_cli_lemma_remove_inheritance: L, I_app_ui_cli_lemma_remove_inheritance {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.remove.inheritance", comment: "") }
}
public protocol I_app_ui_cli_lemma_remove_inheritance: I {}
public final class L_app_ui_cli_lemma_remove_protonym: L, I_app_ui_cli_lemma_remove_protonym {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.remove.protonym", comment: "") }
}
public protocol I_app_ui_cli_lemma_remove_protonym: I {}
public final class L_app_ui_cli_lemma_rename: L, I_app_ui_cli_lemma_rename {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.rename", comment: "") }
}
public protocol I_app_ui_cli_lemma_rename: I {}
public extension I_app_ui_cli_lemma_rename {
	var `to`: L_app_ui_cli_lemma_rename_to { .init("\(__).to") }
}
public final class L_app_ui_cli_lemma_rename_to: L, I_app_ui_cli_lemma_rename_to {
	public override class var localized: String { NSLocalizedString("app.ui.cli.lemma.rename.to", comment: "") }
}
public protocol I_app_ui_cli_lemma_rename_to: I {}
public final class L_app_ui_cli_reset: L, I_app_ui_cli_reset {
	public override class var localized: String { NSLocalizedString("app.ui.cli.reset", comment: "") }
}
public protocol I_app_ui_cli_reset: I {}
public final class L_app_ui_cli_select: L, I_app_ui_cli_select {
	public override class var localized: String { NSLocalizedString("app.ui.cli.select", comment: "") }
}
public protocol I_app_ui_cli_select: I {}
public extension I_app_ui_cli_select {
	var `next`: L_app_ui_cli_select_next { .init("\(__).next") }
	var `previous`: L_app_ui_cli_select_previous { .init("\(__).previous") }
}
public final class L_app_ui_cli_select_next: L, I_app_ui_cli_select_next {
	public override class var localized: String { NSLocalizedString("app.ui.cli.select.next", comment: "") }
}
public protocol I_app_ui_cli_select_next: I {}
public final class L_app_ui_cli_select_previous: L, I_app_ui_cli_select_previous {
	public override class var localized: String { NSLocalizedString("app.ui.cli.select.previous", comment: "") }
}
public protocol I_app_ui_cli_select_previous: I {}
public final class L_app_ui_control: L, I_app_ui_control {
	public override class var localized: String { NSLocalizedString("app.ui.control", comment: "") }
}
public protocol I_app_ui_control: I_app_ui_view {}
public extension I_app_ui_control {
	var `event`: L_app_ui_control_event { .init("\(__).event") }
}
public final class L_app_ui_control_event: L, I_app_ui_control_event {
	public override class var localized: String { NSLocalizedString("app.ui.control.event", comment: "") }
}
public protocol I_app_ui_control_event: I {}
public extension I_app_ui_control_event {
	var `tap`: L_app_ui_control_event_tap { .init("\(__).tap") }
}
public final class L_app_ui_control_event_tap: L, I_app_ui_control_event_tap {
	public override class var localized: String { NSLocalizedString("app.ui.control.event.tap", comment: "") }
}
public protocol I_app_ui_control_event_tap: I {}
public final class L_app_ui_search: L, I_app_ui_search {
	public override class var localized: String { NSLocalizedString("app.ui.search", comment: "") }
}
public protocol I_app_ui_search: I {}
public extension I_app_ui_search {
	var `did`: L_app_ui_search_did { .init("\(__).did") }
	var `prompt`: L_app_ui_search_prompt { .init("\(__).prompt") }
	var `query`: L_app_ui_search_query { .init("\(__).query") }
}
public final class L_app_ui_search_did: L, I_app_ui_search_did {
	public override class var localized: String { NSLocalizedString("app.ui.search.did", comment: "") }
}
public protocol I_app_ui_search_did: I {}
public extension I_app_ui_search_did {
	var `end`: L_app_ui_search_did_end { .init("\(__).end") }
	var `start`: L_app_ui_search_did_start { .init("\(__).start") }
}
public final class L_app_ui_search_did_end: L, I_app_ui_search_did_end {
	public override class var localized: String { NSLocalizedString("app.ui.search.did.end", comment: "") }
}
public protocol I_app_ui_search_did_end: I {}
public final class L_app_ui_search_did_start: L, I_app_ui_search_did_start {
	public override class var localized: String { NSLocalizedString("app.ui.search.did.start", comment: "") }
}
public protocol I_app_ui_search_did_start: I {}
public final class L_app_ui_search_prompt: L, I_app_ui_search_prompt {
	public override class var localized: String { NSLocalizedString("app.ui.search.prompt", comment: "") }
}
public protocol I_app_ui_search_prompt: I {}
public final class L_app_ui_search_query: L, I_app_ui_search_query {
	public override class var localized: String { NSLocalizedString("app.ui.search.query", comment: "") }
}
public protocol I_app_ui_search_query: I {}
public extension I_app_ui_search_query {
	var `did`: L_app_ui_search_query_did { .init("\(__).did") }
}
public final class L_app_ui_search_query_did: L, I_app_ui_search_query_did {
	public override class var localized: String { NSLocalizedString("app.ui.search.query.did", comment: "") }
}
public protocol I_app_ui_search_query_did: I {}
public extension I_app_ui_search_query_did {
	var `change`: L_app_ui_search_query_did_change { .init("\(__).change") }
	var `submit`: L_app_ui_search_query_did_submit { .init("\(__).submit") }
}
public final class L_app_ui_search_query_did_change: L, I_app_ui_search_query_did_change {
	public override class var localized: String { NSLocalizedString("app.ui.search.query.did.change", comment: "") }
}
public protocol I_app_ui_search_query_did_change: I {}
public final class L_app_ui_search_query_did_submit: L, I_app_ui_search_query_did_submit {
	public override class var localized: String { NSLocalizedString("app.ui.search.query.did.submit", comment: "") }
}
public protocol I_app_ui_search_query_did_submit: I {}
public final class L_app_ui_view: L, I_app_ui_view {
	public override class var localized: String { NSLocalizedString("app.ui.view", comment: "") }
}
public protocol I_app_ui_view: I {}
public extension I_app_ui_view {
	var `did`: L_app_ui_view_did { .init("\(__).did") }
}
public final class L_app_ui_view_did: L, I_app_ui_view_did {
	public override class var localized: String { NSLocalizedString("app.ui.view.did", comment: "") }
}
public protocol I_app_ui_view_did: I {}
public extension I_app_ui_view_did {
	var `appear`: L_app_ui_view_did_appear { .init("\(__).appear") }
	var `disappear`: L_app_ui_view_did_disappear { .init("\(__).disappear") }
}
public final class L_app_ui_view_did_appear: L, I_app_ui_view_did_appear {
	public override class var localized: String { NSLocalizedString("app.ui.view.did.appear", comment: "") }
}
public protocol I_app_ui_view_did_appear: I {}
public final class L_app_ui_view_did_disappear: L, I_app_ui_view_did_disappear {
	public override class var localized: String { NSLocalizedString("app.ui.view.did.disappear", comment: "") }
}
public protocol I_app_ui_view_did_disappear: I {}