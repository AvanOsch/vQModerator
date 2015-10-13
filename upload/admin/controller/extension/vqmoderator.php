<?php
class ControllerExtensionVqmoderator extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/vqmoderator');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/vqmoderator.css');
		$this->document->addStyle('view/javascript/codemirror/codemirror.css');
		$this->document->addScript('view/javascript/codemirror/codemirror.js');
		$this->document->addScript('view/javascript/codemirror/css.js');
		$this->document->addScript('view/javascript/codemirror/clike.js');
		$this->document->addScript('view/javascript/codemirror/htmlmixed.js');
		$this->document->addScript('view/javascript/codemirror/javascript.js');
		$this->document->addScript('view/javascript/codemirror/php.js');
		$this->document->addScript('view/javascript/codemirror/xml.js');
		$this->document->addScript('view/javascript/codemirror/matchbrackets.js');
		$this->document->addScript('view/javascript/jscolor.js');
		// Added back jQuery UI, because I don't want to figure out OpenCart AutoComplete (common.js), and need $.dialog()
		$this->document->addScript('view/javascript/jquery/ui/jquery-ui.min.js');
		$this->document->addStyle('view/javascript/jquery/ui/jquery-ui.min.css');

		$this->load->model('extension/modification');

		$this->getMod();
	}

	public function xml(){
		$this->load->model('extension/modification');

		if(!isset($this->request->get['mod'])){
			return false;
		}
		$xml = $this->model_extension_modification->getModification($this->request->get['mod']);
		if (strtolower(substr($xml['xml'], -4)) == '.xml') {
			$file = dirname(DIR_SYSTEM) . '/' . $xml['xml'] . ($xml['status'] ? '' : '_');
			$xml['xml'] = file_get_contents($file);
		}

		echo $xml['xml'];
	}

	protected function getMod() {
		$data['name'] = '';
		$data['xml'] = '"<modification><file><operation></operation></file></modification>"';
		$data['code'] = '';
		$data['author'] = '';
		$data['version'] = '';
		$data['link'] = '';
		$data['files'] = array();
		$data['mod_sql'] = '';
		$data['mod_php'] = '';
		$data['mod_type'] = 'ocmod';
		$data['mod_file'] = '';
		$data['status'] = '';
		$data['modification_id'] = '';
		$url = '';
		if (isset($this->request->get['mod'])) {
			//edit mod
			$mod = $this->model_extension_modification->getModification($this->request->get['mod']);
			if (empty($mod)) {
				$this->session->data['warning'] = $this->language->get('warning_load_fail');
			} else {
				$files = $this->model_extension_modification->getModFiles($this->request->get['mod']);
				$data['name'] = $mod['name'];
				$data['xml'] = ''; // Load xml with seperate request
				$data['code'] = $mod['code'];
				$data['author'] = $mod['author'];
				$data['version'] = $mod['version'];
				$data['link'] = $mod['link'];
				$data['files'] = (isset($files['files']) && $files['files']) ? unserialize($files['files']) : array();
				$data['mod_sql'] = isset($files['install_sql']) ? $files['install_sql'] : '';
				$data['mod_php'] = isset($files['install_php']) ? $files['install_php'] : '';
				$data['mod_type'] = strtolower($mod['type']) . (($data['files'] || $data['mod_sql'] || $data['mod_php']) ? 'z' : '');
				$data['mod_file'] = (strtolower(substr($mod['xml'], -4)) == '.xml') ? $mod['xml'] : '';
				$data['status'] = $mod['status'];
				$data['modification_id'] = $mod['modification_id'];
				$url = "&mod=" . $this->request->get['mod'];
			}
		}

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_version'] = $this->language->get('entry_version');
		$data['entry_vqmver'] = $this->language->get('entry_vqmver');
		$data['entry_vqm_required'] = $this->language->get('entry_vqm_required');
		$data['entry_author'] = $this->language->get('entry_author');
		$data['entry_code'] = $this->language->get('entry_code');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_link'] = $this->language->get('entry_link');
		$data['entry_mod_type'] = $this->language->get('entry_mod_type');
		$data['entry_mod_sql'] = $this->language->get('entry_mod_sql');
		$data['entry_mod_php'] = $this->language->get('entry_mod_php');
		$data['entry_mod_files'] = $this->language->get('entry_mod_files');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_file_path'] = $this->language->get('entry_file_path');
		$data['entry_file_error'] = $this->language->get('entry_file_error');
		$data['entry_search'] = $this->language->get('entry_search');
		$data['entry_ignoreif'] = $this->language->get('entry_ignoreif');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_offset'] = $this->language->get('entry_offset');
		$data['entry_index'] = $this->language->get('entry_index');
		$data['entry_trim'] = $this->language->get('entry_trim');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_regex'] = $this->language->get('entry_regex');
		$data['entry_error'] = $this->language->get('entry_error');
		$data['entry_add'] = $this->language->get('entry_add');
		$data['entry_add_file'] = $this->language->get('entry_add_file');
		$data['entry_info'] = $this->language->get('entry_info');
		$data['entry_remove'] = $this->language->get('entry_remove');

		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_version'] = $this->language->get('placeholder_version');
		$data['placeholder_vqmver'] = '2.5.1';
		$data['placeholder_author'] = $this->language->get('placeholder_author');
		$data['placeholder_code'] = $this->language->get('placeholder_code');
		$data['placeholder_filename'] = $this->language->get('placeholder_filename');
		$data['placeholder_link'] = $this->language->get('placeholder_link');
		$data['placeholder_notes'] = $this->language->get('placeholder_notes');
		$data['placeholder_files'] = $this->language->get('placeholder_files');
		$data['placeholder_autosave'] = $this->language->get('placeholder_autosave');

		$data['text_file_header'] = $this->language->get('text_file_header');
		$data['text_operation_header'] = $this->language->get('text_operation_header');
		$data['text_index'] = $this->language->get('text_index');
		$data['text_offset'] = $this->language->get('text_offset');
		$data['text_limit'] = $this->language->get('text_limit');
		$data['text_position'] = $this->language->get('text_position');
		$data['text_trim'] = $this->language->get('text_trim');
		$data['text_error'] = $this->language->get('text_error');
		$data['text_abort'] = $this->language->get('text_abort');
		$data['text_log'] = $this->language->get('text_log');
		$data['text_skip'] = $this->language->get('text_skip');
		$data['text_replace'] = $this->language->get('text_replace');
		$data['text_ibefore'] = $this->language->get('text_ibefore');
		$data['text_before'] = $this->language->get('text_before');
		$data['text_iafter'] = $this->language->get('text_iafter');
		$data['text_after'] = $this->language->get('text_after');
		$data['text_top'] = $this->language->get('text_top');
		$data['text_bottom'] = $this->language->get('text_bottom');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_mod_config'] = $this->language->get('text_mod_config');
		$data['text_ignoreif_needs'] = $this->language->get('text_ignoreif_needs');
		$data['text_search_found'] = $this->language->get('text_search_found');
		$data['text_search_founds'] = $this->language->get('text_search_founds');
		$data['text_search_not_found'] = $this->language->get('text_search_not_found');
		$data['text_search_not_file'] = $this->language->get('text_search_not_file');
		$data['text_expand'] = $this->language->get('text_expand');
		$data['text_collapse'] = $this->language->get('text_collapse');
		$data['text_this_file'] = $this->language->get('text_this_file');
		$data['text_this_operation'] = $this->language->get('text_this_operation');
		$data['text_prev_operations'] = $this->language->get('text_prev_operations');
		$data['text_all_operations'] = $this->language->get('text_all_operations');
		$data['text_modpack'] = $this->language->get('text_modpack');
		$data['text_confirm_upload'] = $this->language->get('text_confirm_upload');
		$data['text_seconds_togo'] = $this->language->get('text_seconds_togo');

		$data['tooltip_vqm_required'] = $this->language->get('tooltip_vqm_required');
		$data['tooltip_path'] = $this->language->get('tooltip_path');
		$data['tooltip_search'] = $this->language->get('tooltip_search');
		$data['tooltip_regex'] = $this->language->get('tooltip_regex');
		$data['tooltip_limit'] = $this->language->get('tooltip_limit');
		$data['tooltip_action'] = $this->language->get('tooltip_action');
		$data['tooltip_offset'] = $this->language->get('tooltip_offset');
		$data['tooltip_index'] = $this->language->get('tooltip_index');
		$data['tooltip_trim_search'] = $this->language->get('tooltip_trim_search');
		$data['tooltip_trim_add'] = $this->language->get('tooltip_trim_add');
		$data['tooltip_notes'] = $this->language->get('tooltip_notes');
		$data['tooltip_replace'] = $this->language->get('tooltip_replace');
		$data['tooltip_ignoreif'] = $this->language->get('tooltip_ignoreif');
		$data['tooltip_ocmod_only'] = $this->language->get('tooltip_ocmod_only');
		$data['tooltip_code'] = $this->language->get('tooltip_code');
		$data['tooltip_mod_type'] = $this->language->get('tooltip_mod_type');
		$data['tooltip_mod_sql'] = $this->language->get('tooltip_mod_sql');
		$data['tooltip_mod_php'] = $this->language->get('tooltip_mod_php');
		$data['tooltip_mod_files'] = $this->language->get('tooltip_mod_files');
		$data['tooltip_autosave'] = $this->language->get('tooltip_autosave');

		$data['button_update'] = $this->language->get('button_update');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_settings'] = $this->language->get('button_settings');
		$data['button_upload'] = $this->language->get('button_upload');

		$data['error_loading'] = $this->language->get('error_loading');
		$data['error_saving'] = $this->language->get('error_saving');
		$data['error_modification'] = $this->language->get('error_modification');
		$data['error_position_all'] = $this->language->get('error_position_all');
		$data['error_file_selected'] = $this->language->get('error_file_selected');
		$data['error_no_code'] = $this->language->get('error_no_code');
		$data['warning_no_file_selected'] = $this->language->get('warning_no_file_selected');
		$data['warning_parse_fail'] = $this->language->get('warning_parse_fail');

		$data['link_update']    = $this->url->link('extension/vqmoderator/update', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['link_save']      = $this->url->link('extension/vqmoderator/save', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['link_cancel']    = $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_settings']  = $this->url->link('extension/vqmoderator/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_xml']       = $this->url->link('extension/vqmoderator/xml', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['link_autocompl'] = $this->url->link('extension/vqmoderator/autocomplete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['link_config']    = $this->url->link('extension/vqmoderator/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_test_search'] = $this->url->link('extension/vqmoderator/checksearch', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_upload']    = $this->url->link('extension/vqmoderator/upload', 'token=' . $this->session->data['token'], 'SSL');

		$data['mod_config'] = $this->settings('html');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_modifications'),
			'href' => $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/vqmoderator', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} elseif (isset($this->session->data['warning'])) {
			$data['error_warning'] = $this->session->data['warning'];
			unset($this->session->data['warning']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/vqmoderator.tpl', $data));
	}

	public function save() {
		$this->load->language('extension/vqmoderator');

		if ($this->validate()) {
			if (!isset($this->request->post['modification_id'])) {
				$this->session->data['warning'] = $this->language->get('warning_save_empty');
			} else {
				$this->load->model('extension/modification');
				$this->request->post['xml'] = html_entity_decode($this->request->post['xml']);
				// Check for vQMod file, or file in /system/ (Save to file)
				$mod_type = $this->request->post['mod_type'];
				$file = $this->request->post['mod_file'];
				$filecode = str_replace(array('.vqmod.xml','.ocmod.xml','.xml'), '', basename($file));
				$filename = ($this->request->post['code'] != $filecode) ? dirname($file) . '/' . $this->request->post['code'] . '.' . substr($mod_type, 0, 5) . '.xml' : $file;
				if (!$file && substr($mod_type, 0, 5) == 'vqmod') $filename = 'vqmod/xml' . $filename;
				if (!$this->request->post['status'] && substr($filename, -4) == '.xml') $filename .= '_'; // Set filename to disabled
				if (($filename && substr($mod_type, 0, 5) == 'vqmod') || ($file && $mod_type == 'ocmod')) {
					if (file_put_contents(DIR_UPLOAD . basename($filename), $this->request->post['xml'])) {
						if ($this->model_extension_modification->renameFile(DIR_UPLOAD . basename($filename), dirname(DIR_SYSTEM) . '/' . $filename)) {
							if ($file && $file != $filename && file_exists(dirname(DIR_SYSTEM) . '/' . $file)) $this->model_extension_modification->deleteFile(dirname(DIR_SYSTEM) . '/' . $file);
							$this->request->post['xml'] = rtrim($filename, '_');
						} else {
							$this->session->data['warning'] = sprintf($this->language->get('error_move_file_to'), $filename);
							$this->response->redirect($this->url->link('extension/modification/refresh', 'token=' . $this->session->data['token'], 'SSL'));
						}
					}
				}
				if (!isset($this->request->get['mod'])) {
					if ($this->model_extension_modification->addModification($this->request->post)) {
						$this->session->data['success'] = $this->language->get('text_save');
					} else {
						$this->session->data['warning'] = $this->language->get('warning_save_fail');
					}
				} else {
					if ($this->model_extension_modification->saveModification($this->request->post)) {
						$this->session->data['success'] = $this->language->get('text_save');
					} else {
						$this->session->data['warning'] = $this->language->get('warning_save_fail');
					}
				}
			}
		}
		$this->response->redirect($this->url->link('extension/modification/refresh', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function update() {
		$this->load->language('extension/vqmoderator');

		$json = array();
		if ($this->validate()) {
			if (!isset($this->request->post['modification_id'])) {
				$json['warning'] = $this->language->get('warning_save_empty');
			} else {
				$this->load->model('extension/modification');
				$this->request->post['xml'] = html_entity_decode($this->request->post['xml']);
				// Check for vQMod file, or file in /system/ (Save to file)
				$mod_type = $this->request->post['mod_type'];
				$file = $this->request->post['mod_file'];
				$filecode = str_replace(array('.vqmod.xml','.ocmod.xml','.xml'), '', basename($file));
				$filename = ($this->request->post['code'] != $filecode) ? dirname($file) . '/' . $this->request->post['code'] . '.' . substr($mod_type, 0, 5) . '.xml' : $file;
				if (!$file && substr($mod_type, 0, 5) == 'vqmod') $filename = 'vqmod/xml' . $filename;
				if (!$this->request->post['status'] && substr($filename, -4) == '.xml') $filename .= '_'; // Set file to disabled
				if (($filename && substr($mod_type, 0, 5) == 'vqmod') || ($file && $mod_type == 'ocmod')) {
					if (file_put_contents(DIR_UPLOAD . basename($filename), $this->request->post['xml'])) {
						if ($this->model_extension_modification->renameFile(DIR_UPLOAD . basename($filename), dirname(DIR_SYSTEM) . '/' . $filename)) {
							if ($file && $file != $filename && file_exists(dirname(DIR_SYSTEM) . '/' . $file)) $this->model_extension_modification->deleteFile(dirname(DIR_SYSTEM) . '/' . $file);
							$this->request->post['xml'] = rtrim($filename, '_');
						} else {
							$json['warning'] = sprintf($this->language->get('error_move_file_to'), $file);
							$this->response->setOutput(json_encode($json));
						}
					}
				}
				if (!isset($this->request->get['mod'])) {
					$new_id = $this->model_extension_modification->addModification($this->request->post);
					if ($new_id) {
						$json['success'] = $this->language->get('text_update');
						$json['id'] = $new_id;
					} else {
						$json['warning'] = $this->language->get('warning_save_fail');
					}
				} else {
					if ($this->model_extension_modification->saveModification($this->request->post)) {
						$json['success'] = $this->language->get('text_update');
					} else {
						$json['warning'] = $this->language->get('warning_save_fail');
					}
				}
			}
		}
		if (isset($json['success'])) $this->load->controller('extension/modification/refresh', true);

		$this->response->setOutput(json_encode($json));
	}

	// settings does 3 things: Save settings ($posted = array), Get settings ($get), and Save first Install (!$posted && !$get)
	public function settings($get = false) {
		$this->load->language('extension/vqmoderator');
		$this->load->model('setting/setting');

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			$json = array();
			if (!$this->validate()) {
				$json['warning'] = $this->language->get('error_permission');
			}
			$data = $this->request->post;
		} else {
			$data = $this->model_setting_setting->getSetting('vqmod');
		}
		// Make string one folder deep, with trailing slash
		$data['vqmod_mod_test'] = (isset($data['vqmod_mod_test']) && $data['vqmod_mod_test']) ? rtrim($data['vqmod_mod_test'], '/') . '/' : '';
		$sorted = array(
			'vqmod_mod_test' => $data['vqmod_mod_test'],
			'vqmod_test_delay' => (isset($data['vqmod_test_delay']) ? $data['vqmod_test_delay'] : 800),
			'vqmod_text_height' => (isset($data['vqmod_text_height']) ? $data['vqmod_text_height'] : 250),
			'vqmod_show_trim' => (isset($data['vqmod_show_trim']) ? $data['vqmod_show_trim'] : 1),
			'vqmod_show_regex' => (isset($data['vqmod_show_regex']) ? $data['vqmod_show_regex'] : 1),
			'vqmod_show_info' => (isset($data['vqmod_show_info']) ? $data['vqmod_show_info'] : 1),
			'vqmod_show_test' => (isset($data['vqmod_show_test']) ? $data['vqmod_show_test'] : 1),
			'vqmod_color_main' => (isset($data['vqmod_color_main']) ? $data['vqmod_color_main'] : '#C8C8C8'),
			'vqmod_color_file' => (isset($data['vqmod_color_file']) ? $data['vqmod_color_file'] : '#C7DFEC'),
			'vqmod_color_oper' => (isset($data['vqmod_color_oper']) ? $data['vqmod_color_oper'] : '#EEF5F9'),
			'vqmod_updates' => (isset($data['vqmod_updates']) ? $data['vqmod_updates'] : 1),
		);
		if ($get === 'html') {
			// Return configuration page html
			$checkbox = array('vqmod_show_trim', 'vqmod_show_regex', 'vqmod_show_info', 'vqmod_show_test', 'vqmod_updates');
			$vqdir = array('vqmod_mod_test');
			$html = "  <table style=\"width:100%\">\n";
			foreach ($sorted as $vqname => $vqval) {
				$help = false;
				$html .= "    <tr>\n";
					$html .= "      <td class=\"col-sm-4\">\n".
							"        <label class=\"control-label\">";
					if ($this->language->get('text_' . $vqname) != 'text_' . $vqname) {
						$html .= "<span data-toggle=\"tooltip\" title=\"" . $this->language->get('text_' . $vqname) . "\">";
						$help = true;
					}
					$html .= $this->language->get('entry_' . $vqname);
					if ($help) $html .= "</span>";
					$html .= "</label>\n".
							"      </td>\n";
				if (in_array($vqname, $checkbox)) {
					$html .= "      <td class=\"col-sm-8\"><input name=\"" . $vqname . "\" type=\"checkbox\" value=\"" . $vqval . "\" " . ($vqval ? 'checked="checked" ' : '') . "data-orig=\"" . $vqval . "\" class=\"form-control\"/></td>\n";
				} else {
					$html .= "      <td class=\"col-sm-8\"><input name=\"" . $vqname . "\"" . (in_array($vqname, $vqdir) ? ' id="path_' . str_replace('vqmod_', '', $vqname) . '"' : '') . " type=\"text\" class=\"form-control" . (in_array($vqname, $vqdir) ? ' vqdir' : '') . (strpos($vqname, 'color') ? ' color {hash:true} vqcolor" style="width:120px;" id="' . str_replace('vqmod_', '', $vqname) : '') . "\" value=\"" . $vqval . "\" data-orig=\"" . $vqval . "\"/></td>\n";
				}
				$html .= "    </tr>\n";
			}
			$html .= "  </table>\n";
			return $html;
		}
		if (isset($this->request->post) || $this->config->get('vqmod_updates') === null) {
			// Save settings if POSTed, or if newest setting is not set (first install/update)
			foreach ($sorted as $key => $val) $this->config->set($key, $val);
			$this->model_setting_setting->editSetting('vqmod', $sorted);
		}
		$json['success'] = $this->language->get('text_settings_success');
		$this->response->setOutput(json_encode($json));
	}

	// Generate all enabled modifications to structured directories
	public function generateAll() {
		$tests = $this->config->get('vqmod_mod_test');
		if ($tests) {
			$files = $ofiles = $json = array();
			$use_errors = libxml_use_internal_errors(true); // Save error setting
			$xml_dir = '../vqmod/xml/';
			$dirfiles = glob($xml_dir . '*.xml');
			// Check all vQMod xml files for files to mod
			foreach ($dirfiles as $path) {
				$file = basename($path);
				if ($file != 'vqmod_opencart.xml') {
					$xml = simplexml_load_file($path);
					if (isset($xml->file)) {
						foreach ($xml->file as $file) {
							// Collect all the files to mod
							$thefiles = explode(',', $file['name']);
							foreach ($thefiles as $filename) {
								$filename = (isset($file['path']) ? $file['path'] : '') . trim($filename);
								if (!in_array($filename, $files)) $files[] = $filename;
							}
						}
					}
				}
			}
			libxml_use_internal_errors($use_errors); // Reset error setting

			$this->load->language('extension/modification');
			$this->load->model('extension/modification');
			// Refresh OCMOD files, clear vQMod files, and delete previous generated files
			$this->load->controller('extension/modification/refresh', true);
			$path = array('../' . $tests . 'modded/*');
			while (count($path) != 0) {
				$next = array_shift($path);
				foreach (glob($next) as $file) {
					if (is_dir($file)) {
						$path[] = $file . '/*';
					}
					$ofiles[] = $file;
				}
			}
			rsort($ofiles);
			$this->model_extension_modification->deleteFiles($ofiles);
			// Generate and copy vQMod files
			$success = ($files) ? false : true;
			if ($files) {
				foreach ($files as $file) {
					$genfiles = glob('../' . $file);
					foreach ($genfiles as $file) {
						if (is_file($file)) {
							$file = str_replace('../', '', $file);
							$getfile = (file_exists(DIR_MODIFICATION . $file) ? DIR_MODIFICATION : '') . $file;
							$genfile = VQMod::modcheck($getfile, $file);
							if (is_file($genfile)) {
								$newfile = $tests . 'modded/' . $file;
								$success = $this->model_extension_modification->copyFile($genfile, $newfile, true);
								if (!$success) {
									$json['error'] = 'Could not copy <b>' . $genfile . '</b> to <b>' . $newfile . '</b>';
									break 2;
								}
							}
						}
					}
				}
			}
			// Copy OCMod files to test folder (if not already there)
			if ($success) {
				$files = array();
				$path = array(DIR_MODIFICATION . '*');
				while (count($path) != 0) {
					$next = array_shift($path);
					foreach (glob($next) as $file) {
						if (is_dir($file)) {
							$path[] = $file . '/*';
						} else {
							$files[] = $file;
						}
					}
				}
				rsort($files);
				// Copy all modification files
				foreach ($files as $file) {
					$newfile = str_replace(DIR_MODIFICATION, $tests . 'modded/', $file);
					if ($file != DIR_MODIFICATION . 'index.html' && !file_exists('../' . $newfile) && is_file($file)) {
						$success = $this->model_extension_modification->copyFile($file, $newfile, true);
						if (!$success) {
							$json['error'] = 'Could not copy <b>' . $file . '</b> to <b>' . $newfile . '</b>';
							break;
						}
					}
				}
				if (!$json) $json['success'] = $this->language->get('text_generate_done');
			}
			$this->model_extension_modification->doFTP(false);
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function autocomplete() {
		$json = array();

		$dir = (isset($this->request->get['dir'])) ? $this->request->get['dir'] : false;
		$path = (isset($this->request->get['path'])) ? $this->request->get['path'] : '';
		$files = (isset($this->request->get['files'])) ? (int)$this->request->get['files'] : 1;
		$ocmod = (isset($this->request->get['ocmod'])) ? true : false;
		$exts = (isset($this->request->get['ext'])) ? array() : array('php', 'tpl');
		if ($dir !== false) {
			$json = $this->getTree('../' . $path, $dir, $files, $ocmod, $exts);
		}
		if (!$json && $dir && file_exists('../' . $path . $dir)) $json[] = $dir;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function getTree($path = '../', $file = '', $files = true, $ocmod = false, $exts = array('php', 'tpl')) {
		$ignore = array('config-dist.php', 'install', 'nbproject', 'netbeans.php', '.svn', '.', '..');
		if ($ocmod) $ignore[] = 'image';
		$real = false;
		if ($path === true) {
			$real = true;
			$path = '../';
		}
		$tree = array();

		$multi = explode(',', $file);
		if (isset($multi[1])) {
			$file = array_pop($multi);
			$multi = implode(',', $multi) . ',';
		} else {
			$multi = '';
		}
		$treefile = explode('/', $file);
		array_pop($treefile);
		$treefile = implode('/', $treefile);
		if ($treefile) $treefile .= '/';
		$treefile = $multi . $treefile;
		if (substr($file, -1) != '*') $file .= '*';
		$treefiles = glob($path . $file);
		foreach ($treefiles as $file) {
			$tfile = basename($file);
			if (!in_array($tfile, $ignore)) {
				$tfile = ($real) ? $file : $treefile . $tfile;
				if (is_file($file) && $files && !in_array($tfile, $tree)) {
					$ext = explode('.', $file);
					$ext = array_pop($ext);
					if (!$exts || in_array($ext, $exts)) $tree[] = $tfile;
				} elseif (is_dir($file) && !in_array($tfile . '/', $tree)) {
					$tree[] = $tfile . '/';
				}
			}
		}
		return $tree;
	}

	public function checksearch() {
		$found = array();
		$file = (isset($this->request->post['file'])) ? $this->request->post['file'] : false;
		$search = (isset($this->request->post['search'])) ? htmlspecialchars_decode($this->request->post['search']) : false;
		$regex = isset($this->request->post['regex']);
		if (strpos($file, '*') !== false) { // Check first file found (Maybe we can do better?)
			// Get english dir for language wildcards (should always exist)
			if (strpos($file, '/language/*/')) $file = str_replace('/language/*/', '/language/english/', $file);
			$dirs = glob('../' . $file);
			if ($dirs) {
				$file = str_replace('../', '', $dirs[0]);
			}
		}
		if ($file && $search && file_exists('../' . $file)) {
			$tests = '../' . $this->config->get('vqmod_mod_test');
			if ($this->config->get('vqmod_mod_test') && file_exists($tests) && is_dir($tests)) {
				$dirfiles = glob($tests . '*');
				if (!$dirfiles) $dirfiles = array();
				foreach ($dirfiles as $path) {
					if (is_dir($path)) {
						$files = $path . '/' . $file;
						if (file_exists($files)) {
							$files = file_get_contents($files);
							$found[basename($path)] = substr_count($files, $search);
						} elseif (file_exists($path . '/upload/' . $file)) {
							$files = file_get_contents($path . '/upload/' . $file);
							$found[basename($path)] = substr_count($files, $search);
						} else {
							$found[basename($path)] = 'no file';
						}
					}
				}
			}
			$file = file_get_contents('../' . $file);
			if ($regex) $count = preg_match($search, $file);
			else $count = substr_count($file, $search);
			if ($this->config->get('vqmod_mod_test') && file_exists($tests) && is_dir($tests)) $found['Installed'] = $count;
			else $found['Result'] = $count;
		}
		$this->response->setOutput(json_encode($found));
	}

	public function upload() {
		$this->load->language('extension/vqmoderator');

		$json = array();

		// Check user has permission
		if (!$this->validate()) {
			$json['error'] = $this->language->get('error_permission');
		}
		if (!$json) {
			if (!empty($this->request->files['file']['name']) && is_file($this->request->files['file']['tmp_name'])) {
				// Sanitize the filename
				$filename = basename(html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8'));
				// Validate the filename length
				if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 128)) {
					$json['error'] = $this->language->get('error_filename');
				}
				// Return any upload error
				if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
					$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
				}
			} else {
				$json['error'] = $this->language->get('error_upload');
			}
		}
		if (!$json) {
			$dest = rtrim($this->request->post['dest'], '/') . '/';
			$file = $dest . $filename;
			move_uploaded_file($this->request->files['file']['tmp_name'], DIR_UPLOAD . $filename);
			if (file_exists(DIR_UPLOAD . $filename)) {
				// Use FTP Rename function to move the file
				$this->load->model('extension/modification');
				if (!$this->model_extension_modification->renameFile(DIR_UPLOAD . $filename, dirname(DIR_SYSTEM) . '/' . $file)) {
					$json['error'] = sprintf($this->language->get('error_move_file_to'), $dest);
				} else {
					$json['file'] = $file;
					$json['success'] = $this->language->get('text_upload_success');
				}
			} else {
				$json['error'] = sprintf($this->language->get('error_move_file_to'), 'temporary folder');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function download() {
		$this->load->language('extension/vqmoderator');

		// Check user has permission
		if (!$this->validate()) {
			$this->session->data['warning'] = $this->language->get('error_permission');
			$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL'));
		} elseif (!isset($this->request->get['mod'])) {
			$this->session->data['warning'] = $this->language->get('warning_down_file');
			$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL'));
		} else {
			$this->load->model('extension/modification');
			// If no temp directory exists create it
			$path = DIR_UPLOAD . 'temp-' . md5(mt_rand());
			if (!is_dir($path)) {
				mkdir($path, 0777);
			}
			$mod_id = $this->request->get['mod'];
			$mod = $this->model_extension_modification->getModification($mod_id);
			$pack = $this->model_extension_modification->getModFiles($mod_id);
			if (empty($mod)) {
				$this->session->data['warning'] = $this->language->get('warning_down_file');
				$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				if (substr($mod['xml'], -4) == '.xml') {
					$xmlfile = dirname(DIR_SYSTEM) . '/' . $mod['xml'];
					if (!file_exists($xmlfile) && file_exists($xmlfile . '_')) $xmlfile .= '_';
					$type = 'vqmod';
				} else {
					$xml = simplexml_load_string($mod['xml']);
					$type = (isset($xml->vqmver) || isset($xml->id)) ? 'vqmod' : 'ocmod';
					$xmlfile = $path .'/' . $mod['code'] . '.' . $type . '.xml';
					file_put_contents($xmlfile, $mod['xml']);
				}
			}
			if (isset($pack['files'])) {
				$files = ($pack['files']) ? unserialize($pack['files']) : array();
				// check all files
				$error = '';
				foreach ($files as $fil) {
					$real = dirname(DIR_SYSTEM) . '/' . $fil;
					if (!file_exists($real)) {
						$error .= "<br/>$fil";
					}
				}
				if ($error) {
					$this->session->data['warning'] = $this->language->get('error_pack_files') . $error;
					$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'] . '&cleanup=1', 'SSL'));
				}
				$file = $path . '/' . $mod['code'] . '.' . $type . '.zip';
				$zip = new ZipArchive();
				if ($zip->open($file, ZIPARCHIVE::CREATE) !== true) {
					$this->session->data['warning'] = $this->language->get('error_pack_zip') . $file;
					$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'] . '&cleanup=1', 'SSL'));
				}
				foreach($files as $fil) {
					if (is_dir(dirname(DIR_SYSTEM) . '/' . $fil)) {
						$zip->addEmptyDir('upload/' . $fil);
					} else {
						$zip->addFile(dirname(DIR_SYSTEM) . '/' . $fil, 'upload/' . $fil);
					}
				}
				$zip->addFile($xmlfile, 'install.xml');
				if ($pack['install_sql']) $zip->addFromString('install.sql', $pack['install_sql']);
				if ($pack['install_php']) $zip->addFromString('install.php', $pack['install_php']);
				$zip->close();
			} else {
				$file = $xmlfile;
			}

			if (!headers_sent()) {
				if (is_file($file)) {
					header('Content-Type: application/octet-stream');
					header('Content-Description: File Transfer');
					header('Content-Disposition: attachment; filename="' . basename($file) . '"');
					header('Content-Transfer-Encoding: binary');
					header('Expires: 0');
					header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
					header('Pragma: public');
					header('Content-Length: ' . filesize($file));

					readfile($file, 'rb');
					// Clean up.
					$this->load->controller('extension/installer/clear', true);
					exit;
				} else {
					$this->session->data['warning'] = $this->language->get('warning_down_create');
					$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'] . '&cleanup=1', 'SSL'));
				}
			} else {
				exit('Error: Headers already sent out!');
			}
		}
	}

	protected function validate() {
		$this->load->language('extension/vqmoderator');
		if (!$this->user->hasPermission('modify', 'extension/vqmoderator')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}