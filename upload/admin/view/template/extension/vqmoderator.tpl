<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <input id="autosave" type="text" value="" placeholder="<?php echo $placeholder_autosave;?>" data-toggle="tooltip" title="<?php echo $tooltip_autosave;?>" class="numeric" /> &nbsp; &nbsp; 
        <button onclick="saveMod('update');" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-info save-continue"><i class="fa fa-refresh"></i></button>
        <button onclick="saveMod('save');" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $link_cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
        <button data-toggle="tooltip" title="<?php echo $button_settings; ?>" class="btn btn-default mod-config"><i class="fa fa-gear"></i></button>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid errors">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

    <div class="panel panel-default" style="border: none; box-shadow: none; -webkit-box-shadow: none; -moz-box-shadow: none;">
      <form method="POST" action="" name="save_form" id="save_form">
        <div class="well color_main" style="margin-bottom:0px;">
            <div class="row">
              <div class="col-sm-4">
                <div class="form-group">
                  <label class="control-label" for="name"><?php echo $entry_name; ?></label>
                  <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $placeholder_name;?>" id="name" class="form-control" autocomplete="off">
                </div>
                <div class="form-group">
                  <label class="control-label" for="code"><?php echo $entry_code . ' ' . $tooltip_code; ?></label>
                    <input type="text" name="code" value="<?php echo $code; ?>" placeholder="<?php echo $placeholder_code;?>" id="code" class="form-control" autocomplete="off" aria-describedby="basic-addon2">
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group">
                  <label class="control-label" for="author"><?php echo $entry_author; ?></label>
                  <input type="text" name="author" value="<?php echo $author; ?>" placeholder="<?php echo $placeholder_author;?>" id="author" class="form-control" autocomplete="off">
                </div>
                <div class="form-group">
                  <label class="control-label" for="link"><?php echo $entry_link . ' ' . $tooltip_ocmod_only; ?></label>
                  <input type="text" name="link" value="<?php echo $link; ?>" placeholder="<?php echo $placeholder_link;?>" id="link" class="form-control" autocomplete="off">
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label class="control-label" for="version"><?php echo $entry_version; ?></label>
                  <input type="text" name="version" value="<?php echo $version; ?>" placeholder="<?php echo $placeholder_version;?>" id="version" class="form-control" autocomplete="off">
                </div>
                <div class="form-group vq-only"<?php if (substr($mod_type,0,2) != 'vq') echo ' style="display:none"';?>>
                  <label class="control-label" for="vqmver"><?php echo $entry_vqmver; ?> <span id="vqm-required" data-toggle="tooltip" title="<?php echo $tooltip_vqm_required; ?>" style="display:none; margin-left:20px;"><?php echo $entry_vqm_required;?> <input id="vqmver-required" name="vqmver_required" type="checkbox" value="1" /></span></label>
                  <input type="text" name="vqmver" value="" placeholder="<?php echo $placeholder_vqmver;?>" id="vqmver" class="form-control" autocomplete="off">
                </div>
              </div>
              <div class="col-sm-2">
                <div class="form-group">
                  <label class="control-label" for="status"><?php echo $entry_status; ?></label>
                  <select name="status" id="status" class="form-control">
                    <option value="1"<?php if ($status == 1){echo " selected";}?>>Enabled</option>
                    <option value="0"<?php if ($status == 0){echo " selected";}?>>Disabled</option>
                  </select>
                </div>
                <div class="form-group">
                  <label class="control-label" for="mod_type"><span data-toggle="tooltip" title="<?php echo $tooltip_mod_type; ?>"><?php echo $entry_mod_type; ?></span></label>
                  <select name="mod_type" id="mod_type" class="form-control">
                    <option value="ocmod"<?php if ($mod_type == 'ocmod' || !$mod_type) echo " selected"; ?>>OCMod XML</option>
                    <option value="ocmodz"<?php if ($mod_type == 'ocmodz') echo " selected"; ?>>OCMod Package</option>
                    <option value="vqmod"<?php if ($mod_type == 'vqmod') echo " selected"; ?>>vQMod XML</option>
                    <option value="vqmodz"<?php if ($mod_type == 'vqmodz') echo " selected"; ?>>vQMod Package</option>
                  </select>
                </div>
              </div>
            </div>
            <div>
              <label class="control-label" for="description"><?php echo $entry_description . ' ' . $tooltip_ocmod_only; ?></label>
              <textarea name="description" id="description" class="form-control"></textarea>
            </div>
            <textarea name="xml" id="xmlfile" style="display:none;"></textarea>
            <input type="hidden" name="modification_id" value="<?php echo $modification_id?>">
            <input type="hidden" name="mod_file" value="<?php echo $mod_file?>">
          </div>

          <div id="modpack" class="modpack color_main"<?php if (!strlen($mod_type > 5)) echo ' style="display:none;"';?>><div class="arrow fa fa-lg fa-toggle-down" title="<?php echo $text_expand . $text_modpack;?>"></div>
            <div id="modpack-content" style="display:none;" class="collapseme">
              <div class="vqrow">
                <div class="vqcell"><label class="control-label" for="mod_add_sql"><span data-toggle="tooltip" title="<?php echo $tooltip_mod_sql; ?>"><?php echo $entry_mod_sql;?></div></span></label>
                <div class="vqcell"><input id="mod_add_sql" class="mod-add-install" type="checkbox" value="1" class="form-control" <?php if ($mod_sql) echo 'checked="checked" '; ?>/></div>
              </div>
              <div class="mod_add_sql"<?php if (!$mod_sql) echo ' style="display:none;"';?>>
                <textarea id="add_mod_sql" name="mod_sql" class="vqtext"><?php echo $mod_sql;?></textarea>
              </div>
              <div class="vqrow">
                <div class="vqcell"><label class="control-label" for="mod_add_php"><span data-toggle="tooltip" title="<?php echo $tooltip_mod_php; ?>"><?php echo $entry_mod_php;?></div></span></label>
                <div class="vqcell"><input id="mod_add_php" class="mod-add-install" type="checkbox" value="1" class="form-control" <?php if ($mod_php) echo 'checked="checked" '; ?>/></div>
              </div>
              <div class="mod_add_php"<?php if (!$mod_php) echo ' style="display:none;"';?>>
                <div style="width:100%"><textarea id="add_mod_php" name="mod_php" class="vqtext"><?php echo $mod_php;?></textarea></div>
              </div>
              <div class="vqrow">
                <div class="vqcell" style="position:relative;">
                  <label class="control-label" for="mod-files" style="position:absolute;top:8px;"><span data-toggle="tooltip" title="<?php echo $tooltip_mod_files; ?>"><?php echo $entry_mod_files; ?></span></label>
                </div>
                <div class="vqcell">
                  <div class="input-group" style="width:100%;">
                    <span class="input-group-btn"><button class="btn btn-default" type="button" id="button-upload"><?php echo $button_upload;?></button></span>
                    <input type="text" value="" placeholder="<?php echo $placeholder_files; ?>" id="file_new_mod" class="form-control" />
                    <span class="input-group-btn"><button class="btn btn-default" type="button" onclick="addModFile();"><i class="fa fa-plus-square fa-lg"></i></button></span>
                  </div>
                  <div id="mod-files" class="well well-sm" style="height: 150px; width: 700px; overflow: auto;">
                    <?php foreach ($files as $file) {
                      $fid = (isset($fid)) ? $fid + 1 : 0;
                      $backgr = file_exists('../' . $file) ? '' : ' style="background-color:#FFDFDD;"';?>
                      <div id="mod-file<?php echo $fid; ?>" class="mod-files"<?php echo $backgr;?>><i class="fa fa-minus-circle" onclick="$(this).parent().remove();"></i> <?php echo $file; ?>
                      <input type="hidden" name="mod_files[]" value="<?php echo $file; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>

        <div id="mods">
        </div>

      <div class="pull-left"><?php echo $text_collapse . $text_prev_operations;?> &nbsp;<i class="prev-collapse fa fa-toggle-up fa-lg" style="cursor:pointer;"></i> &nbsp; &nbsp; <?php echo $entry_add_file;?> &nbsp;<i onclick="addOperation(addFile(null, $('.file:last')), null, false);" class="fa fa-plus-square fa-lg" style="cursor:pointer;"></i></div>
      <div class="pull-right">
        <button onclick="saveMod('update');" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-info save-continue"><i class="fa fa-refresh"></i></button>
        <button onclick="saveMod('save');" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $link_cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
    </div>
  </div>
</div>
<div id="mod-config" style="display:none;"><?php echo $mod_config;?></div>
<script type="text/javascript"><!--
  var cache = {}, changed = false, arw = 'fa-toggle-', ficolor = ColorLuminance($('#color_file').val(), -0.4), opcolor = ColorLuminance($('#color_oper').val(), -0.4);
  var update_url = '<?php echo html_entity_decode($link_update);?>', save_url = '<?php echo html_entity_decode($link_save);?>';
  function saveMod(action) {
    if ($('#code').val() == '') {
      alert('<?php echo $error_no_code;?>');
      return false;
    }
    if (action === 'update') $('i', '.save-continue').addClass('fa-spin');
	$('.CodeMirror').each(function(i, el){
      el.CodeMirror.save();
    });
    var xml = makeXML();
    //fix it
    $("#xmlfile").val("<?php echo '<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?>';?>\n<!-- Created using vQModerator's XML Generator by The Wizard of Osch for http://www.crystalcopy.nl //-->\n" + xml.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&amp;/g, "&"));
    //test it's valid xml
    try {
        $.parseXML( $("#xmlfile").val() );
    }
    catch(e) {
        alert('<?php echo $warning_parse_fail;?>');
        console.log(e);
        if (action === 'update') $('i', '.save-continue').removeClass('fa-spin');
        return false;
    }
    //post it
    if (action == 'save') {
      $("#save_form").attr('action', save_url).submit();
    } else {
	  var mod_id = update_url.split('&mod=');
	  $.ajax({
        url : update_url,
        type: 'POST',
        data: $("#save_form").serialize(),
        dataType: 'json',
        success: function(data) {
          var div = $('<div/>').hide();
          if (data.success) {
            div.addClass('alert alert-success').html('<i class="fa fa-check-circle"></i> ' + data.success + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
			if (typeof data.id !== 'undefined' && mod_id.length <= 1) {
				$('input[name="modification_id"]').val(data.id);
				update_url += '&mod=' + data.id;
				save_url += '&mod=' + data.id;
			}
          } else {
            div.addClass('alert alert-danger').html('<i class="fa fa-exclamation-circle"></i> ' + data.warning + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
          }
          $('i', '.save-continue').removeClass('fa-spin');
          $('.errors').prepend(div);
          div.fadeIn(400);
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert('<?php echo $error_saving; ?>' + thrownError);
        }
      });
    }
  }

  $(document).ready(function() {
  <?php if ($xml) { ?>
    readMod($.parseXML(<?php echo $xml; ?>));
  <?php } else { ?>
    $.ajax({
      type: "GET",
      url: "<?php echo html_entity_decode($link_xml); ?>",
      dataType: "xml",
      success: function(xml) {
        readMod(xml);
      },
      error: function(error) {
        alert('<?php echo $error_loading; ?>');
        window.location.href = "<?php echo html_entity_decode($link_cancel); ?>";
      }
    });
  <?php } ?>
  });

  function readMod(xml) {
    if ($(xml).find("modification").length > 1) {
      var html = '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_modification; ?> <button type="button" class="close" data-dismiss="alert">&times;</button> </div>';
      $(".errors").prepend(html);
    }

    var description = $(xml).find('description').html() || '';
    var vqmver = $(xml).find('vqmver').html() || '';
    var vqmreq = $(xml).find('vqmver').attr('required') || false;
    $("#description").val(unCDATA(description));
    $("#vqmver").val(unCDATA(vqmver));
    if (vqmreq) $("#vqmver-required").attr('checked', true);
    $("#vqmver").blur();

    $(xml).find("file").each(function() {
      var el = addFile(this.attributes, false);

      $(this).find("operation").each(function() {
        addOperation(el, this, false);
      });
    });
	if (typeof autoOpen !== 'undefined') {
		$('.arrow:first', '#files_' + autoOpen[0]).not('.ops').click();
		$('.arrow', '#operation_' + autoOpen[0] + '_' + autoOpen[1]).click();
		setTimeout(function() {
			var height = $('#operation_' + autoOpen[0] + '_' + autoOpen[1]).offset().top + $('body').scrollTop();
			$('html, body').animate({ scrollTop: height }, 800);
		}, 800);
	}
  }

function addFile(d, pos) {
  var file = '', path = '', error = '';
  if (!d || d.length == 0) d = false;
  if (d) {
    if (d.getNamedItem('name')) {   // vQMod file
      file = d.getNamedItem('name').value;
      if (d.getNamedItem('path')) path = d.getNamedItem('path').value;
      if (d.getNamedItem('error')) error = d.getNamedItem('error').value;
    } else {                        // OCMod file
      if (d.getNamedItem('path')) file = d.getNamedItem('path').value;
    }
  }
  var idx = $('.file').length, arrow = (pos || !d) ? 'up' : 'down';
	var vqmversion = $('#vqmver').is(':hidden') ? false : parseInt($('#vqmver').val().split('.').join(''));
	var x = "\n<div class=\"file\" id=\"files_" + idx + "\">";
	x += "\n\t<fieldset class=\"fi color_file\" style=\"background-color:" + $('#color_file').val() + ";border-color:" + ficolor + "\">";
	x += "\n\t\t<legend><div class=\"fa fa-minus-circle remover\" data-toggle=\"tooltip\" title=\"<?php echo $entry_remove;?>\" style=\"cursor:pointer\"></div> &nbsp;<?php echo $text_file_header;?></legend>";
	x += "\n\t\t<div class=\"vqtable\">";
	x += "\n\t\t\t<div class=\"vqrow\">";
	x += "\n\t\t\t\t<div class=\"vqcell\"><?php echo $entry_file_path;?></div>";
	x += "\n\t\t\t\t<div class=\"vqcell\"><input id=\"path_" + idx + "\" name=\"path[" + idx + "]\" type=\"text\" value=\"" + path + "\" size=\"" + (path != '' ? path.length : '1') + "\" class=\"form-control vqm230 vq-only\" style=\"width:auto;min-width:0;" + (vqmversion < 230 ? "display:none;" : '') + "\" /><input id=\"file_" + idx + "\" name=\"file[" + idx + "]\" type=\"text\" value=\"" + file + "\" style=\"width:92%;\" class=\"form-control\" /></div>";
	x += "\n\t\t\t</div>";
	x += "\n\t\t\t<div class=\"vqrow file_error_" + idx + " removeme vq-only\"" + (vqmversion === false ? " style=\"display:none;\"" : '') + ">";
	x += "\n\t\t\t\t<div class=\"vqcell\"><?php echo $entry_file_error;?></div>";
	x += "\n\t\t\t\t<div class=\"vqcell\"><select id=\"error_" + idx + "\" name=\"error_" + idx + "\">";
	x += "\n\t\t\t\t\t<option value=\"abort\"" + ((error === 'abort') ? " selected=\"selected\"" : '') + "><?php echo $text_abort;?></option>";
	x += "\n\t\t\t\t\t<option value=\"log\"" + ((error === '' || error === 'log') ? " selected=\"selected\"" : '') + "><?php echo $text_log;?></option>";
	x += "\n\t\t\t\t\t<option value=\"skip\"" + ((error === 'skip') ? " selected=\"selected\"" : '') + "><?php echo $text_skip;?></option>";
	x += "\n\t\t\t\t</select></div>";
	x += "\n\t\t\t\t<div class=\"vqcell\"></div>";
	x += "\n\t\t\t</div>";
	x += "\n\t\t</div>";
	x += "\n\t\t<div class=\"arrow fa " + arw + arrow + " fa-lg removeme\" data-toggle=\"tooltip\" title=\"" + (arrow === 'up' ? '<?php echo $text_collapse;?>' : '<?php echo $text_expand;?>') + "<?php echo $text_this_file;?>\"></div>";
	x += "\n\t\t<div class=\"arrow ops fa " + arw + (d ? 'down' : 'up') + " fa-lg removeme\" data-toggle=\"tooltip\" title=\"" + (d ? '<?php echo $text_expand . $text_all_operations;?>" style="display:none;' : '<?php echo $text_collapse . $text_all_operations;?>') + "\"></div>";
	x += "\n\t\t\t<div class=\"vqadd\" onclick=\"addOperation(addFile(null, $('#files_" + idx + "')), null, false);\">";
	x += "\n\t\t\t\t<?php echo $entry_add_file;?> &nbsp; <div class=\"fa fa-plus-square fa-lg\"></div>";
	x += "\n\t\t\t</div>";
	x += "\n\t</fieldset>";
	x += "\n</div>";

	if (!pos) {
    $('#mods').append(x);
  } else {
    pos.after(x);
  }

	if (!d && pos) {
		var height = $('#files_' + idx).offset().top;
		$('html, body').animate({ scrollTop: height }, 800);
	}
	if (pos) {
		loadAutocomplete(idx, true);
		loadPathcomplete(idx);
	}
  return idx;
}

function addOperation(idx, d, pos) {
  if (!d || $(d).html() == '') d = false;

  var el  = $('#files_' + idx);
  var idx2 = el.children(".operation").length;
  //var after = ( pos || idx2 ) + $(el).children(':not(.operation)').length;

  var search           = $(d).find("search").html()        || '';
  var index            = $(d).find("search").attr('index') || '';
  var trims            = $(d).find("search").attr('trim')  || '';
  var regex            = $(d).find("search").attr('regex') || '';
  var limit            = $(d).find("search").attr('limit') || '';
  var ignoreif         = $(d).find("ignoreif").html()      || '';
  var regif            = $(d).find("ignoreif").attr('regex') || '';
  var error            = $(d).attr('error')                || '';
  var offset           = $(d).find("add").attr('offset')   || $(d).find("search").attr('offset') || '0';
  var trim             = $(d).find("add").attr('trim')     || '';
  var add              = $(d).find("add").html()           || '';
  var position         = $(d).find("add").attr('position') || $(d).find("search").attr('position') || '';
  var info             = $(d).find("notes").html()         || $(d).attr('info') || '';

  if (!pos && d && (!search === '' || (add === '' && position && position !== 'replace') || $('#file_' + idx).val() === '') && typeof autoOpen === 'undefined') var autoOpen = [idx, idx2];
  var vqmversion = $('#vqmver').is(':hidden') ? false : parseInt($('#vqmver').val().split('.').join('')), arrow = (pos || !d) ? 'up' : 'down', hidden = (pos || !d) ? '' : " style=\"display:none;\"";
  var x = "\n\t<div class=\"operation\"" + hidden + " id=\"operation_" + idx + "_" + idx2 + "\">";
  x += "\n\t\t<fieldset class=\"op color_oper\"";
  if (position == 'all') {
    alert('<?php echo $error_position_all;?>');
    if (typeof autoOpen === 'undefined') autoOpen = [idx, idx2];
    x += " style=\"background-color:#FFDEDE;\"";
  } else {
    x += " style=\"background-color:" + $('#color_oper').val() + ";border-color:" + opcolor + "\"";
  }
  x += ">";
  x += "\n\t\t\t<legend><div class=\"fa fa-minus-circle remover\" data-toggle=\"tooltip\" title=\"<?php echo $entry_remove;?>\" style=\"cursor:pointer\"></div> &nbsp;<?php echo $text_operation_header;?></legend>";
  x += "\n\t\t\t<div class=\"vqtable\">";
  x += "\n\t\t\t\t<div class=\"vqrow\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><label class=\"control-label\"><span data-toggle=\"tooltip\" title=\"<?php echo $tooltip_search; ?>\"><?php echo $entry_search;?></span></label><div style=\"float:right;margin-right:15px;\" class=\"hideonall\">";
  x += "<span class=\"vqm230 vq-only\"" + (vqmversion < 230 || vqmversion === false ? " style=\"display:none;\"" : '') + "><small><?php echo $entry_ignoreif;?></small><input id=\"ignore_" + idx + "_" + idx2 + "\" class=\"form-control ignoreif\" type=\"checkbox\" " + ((ignoreif != '' && vqmversion >= 230) ? "checked=\"checked\" " : '') + "/></span>";
  x += "&nbsp;<span class=\"vqregex\"><small><?php echo $entry_regex;?></small><input id=\"regex_" + idx + "_" + idx2 + "\" name=\"regex[" + idx + "][" + idx2 + "]\" type=\"checkbox\" class=\"form-control regex\" value=\"true\" " + ((regex == 'true') ? "checked=\"checked\" " : '') + "/></span>";
  x += "&nbsp;<span class=\"vqtrim\"><small><?php echo $entry_trim;?></small><input id=\"trims_" + idx + "_" + idx2 + "\" name=\"trims[" + idx + "][" + idx2 + "]\" type=\"checkbox\" class=\"form-control\" value=\"true\" " + ((trims == 'false') ? '' : "checked=\"checked\" ") + "/></span></div></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"search_" + idx + "_" + idx2 + "\" name=\"search[" + idx + "][" + idx2 + "]\" type=\"text\" class=\"form-control\" value=\"" + unCDATA(search) + "\" style=\"width:95%;\"" + ((position == 'bottom' || position == 'top' || position == 'all') ? ' readonly="readonly"' : '') + "></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t</div>";
  x += "\n\t\t\t<div class=\"vqtable collapseme vqoptions\"" + hidden + ">";
  x += "\n\t\t\t\t<div class=\"vqtest\"></div>";
  x += "\n\t\t\t\t<div class=\"vqrow\"" + ((!ignoreif || vqmversion < 230 || vqmversion === false) ? ' style="display:none;"' : '') + ">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><label class=\"control-label\"><span data-toggle=\"tooltip\" title=\"<?php echo $tooltip_ignoreif; ?>\"><?php echo $entry_ignoreif;?></span></label><div style=\"float:right;margin-right:15px;\" class=\"hideonall vqregex\"><?php echo $entry_regex;?><input id=\"regif_" + idx + "_" + idx2 + "\" name=\"regif[" + idx + "][" + idx2 + "]\" type=\"checkbox\" class=\"form-control\" value=\"true\" " + ((regif == 'true') ? "checked=\"checked\" " : '') + "/></div></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><textarea id=\"ignoreif_" + idx + "_" + idx2 + "\" name=\"ignoreif[" + idx + "][" + idx2 + "]\" rows=\"3\" style=\"width:65%;\">" + unCDATA(ignoreif) + "</textarea></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow oc-noregex\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_position;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><select id=\"position_" + idx + "_" + idx2 + "\" name=\"position[" + idx + "][" + idx2 + "]\">";
  x += "\n\t\t\t\t\t\t<option value=\"replace\"" + ((!position || position === 'replace') ? " selected=\"selected\"" : '') + "><?php echo $text_replace;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"ibefore\"" + (position === 'ibefore' ? " selected=\"selected\"" : '') + " class=\"vqm240 vq-only\"" + (vqmversion < 240 ? " style=\"display:none;\"" : '') + "><?php echo $text_ibefore;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"before\"" + (position === 'before' ? " selected=\"selected\"" : '') + "><?php echo $text_before;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"iafter\"" + (position === 'iafter' ? " selected=\"selected\"" : '') + " class=\"vqm240 vq-only\"" + (vqmversion < 240 ? " style=\"display:none;\"" : '') + "><?php echo $text_iafter;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"after\"" + (position === 'after' ? " selected=\"selected\"" : '') + "><?php echo $text_after;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"top\"" + (position === 'top' ? " selected=\"selected\"" : '') + " class=\"vq-only\"" + (vqmversion === false ? " style=\"display:none;\"" : '') + "><?php echo $text_top;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"bottom\"" + (position === 'bottom' ? " selected=\"selected\"" : '') + " class=\"vq-only\"" + (vqmversion === false ? " style=\"display:none;\"" : '') + "><?php echo $text_bottom;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"all\"" + (position === 'all' ? " selected=\"selected\"" : '') + " class=\"vq-only\"" + (vqmversion === false ? " style=\"display:none;\"" : '') + " style=\"background-color:#FFEBEB;\"><?php echo $text_all;?></option>";
  x += "\n\t\t\t\t\t</select> &nbsp; <?php echo $text_position;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow oc-noregex\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_offset;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"offset_" + idx + "_" + idx2 + "\" name=\"offset[" + idx + "][" + idx2 + "]\" type=\"text\" value=\"" + offset + "\" style=\"width:40px;\" class=\"form-control numeric\"> &nbsp; <?php echo $text_offset;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow hideonall\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_index;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"index_" + idx + "_" + idx2 + "\" name=\"index[" + idx + "][" + idx2 + "]\" type=\"text\" value=\"" + index + "\" style=\"width:auto;min-width:0;\" size=\"" + (index !== '' ? index.length : 1) + "\" class=\"form-control numeric\"> &nbsp; <?php echo $text_index;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow vq-only\"" + (vqmversion === false ? " style=\"display:none;\"" : '') + ">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_error;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><select id=\"error_" + idx + "_" + idx2 + "\" name=\"error[" + idx + "][" + idx2 + "]\">";
  x += "\n\t\t\t\t\t\t<option value=\"abort\"" + ((!error || error === 'abort') ? " selected=\"selected\"" : '') + "><?php echo $text_abort;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"log\"" + (error === 'log' ? " selected=\"selected\"" : '') + "><?php echo $text_log;?></option>";
  x += "\n\t\t\t\t\t\t<option value=\"skip\"" + (error === 'skip' ? " selected=\"selected\"" : '') + "><?php echo $text_skip;?></option>";
  x += "\n\t\t\t\t\t</select> &nbsp; <?php echo $text_error;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow vqtrim oc-noregex\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_trim;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"trim_" + idx + "_" + idx2 + "\" name=\"trim[" + idx + "][" + idx2 + "]\" type=\"checkbox\" class=\"form-control\" value=\"true\" " + ((trim === 'true') ? "checked=\"checked\" " : '') + "/> &nbsp; <?php echo $text_trim;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow oc-only\"" + ((vqmversion !== false || regex === 'true') ? " style=\"display:none;\"" : '') + ">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_limit;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"limit_" + idx + "_" + idx2 + "\" name=\"limit[" + idx + "][" + idx2 + "]\" type=\"text\" value=\"" + limit + "\" style=\"width:40px;\" class=\"form-control numeric\"/> &nbsp; <?php echo $text_limit;?></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t\t<div class=\"vqrow vqinfo\">";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><?php echo $entry_info;?></div>";
  x += "\n\t\t\t\t\t<div class=\"vqcell\"><input id=\"info_" + idx + "_" + idx2 + "\" name=\"info[" + idx + "][" + idx2 + "]\" type=\"text\" class=\"form-control\" value=\"" + unCDATA(info) + "\" style=\"width:65%;\" /></div>";
  x += "\n\t\t\t\t</div>";
  x += "\n\t\t\t</div>";
  x += "\n\t\t\t<div style=\"width:100%;" + (hidden ? 'display:none;' : '') + "\" class=\"collapseme\"><textarea id=\"add_" + idx + "_" + idx2 + "\" name=\"add[" + idx + "][" + idx2 + "]\" class=\"vqtext\">" + unCDATA(add) + "</textarea></div>";
  x += "\n\t\t\t<div class=\"arrow fa " + arw + arrow + " fa-lg\" data-toggle=\"tooltip\" title=\"" + (hidden ? '<?php echo $text_expand;?>' : '<?php echo $text_collapse;?>') + "<?php echo $text_this_operation;?>\"></div>";
  x += "\n\t\t\t<div class=\"vqadd collapseme\"" + hidden + " onclick=\"addOperation(" + idx + ", null, $(this).closest('.operation'));\">";
  x += "\n\t\t\t\t<?php echo $entry_add;?> &nbsp; <div class=\"fa fa-plus-square fa-lg\"></div>";
  x += "\n\t\t\t</div>";
  x += "\n\t\t</fieldset>";
  x += "\n\t</div>";

  if (!pos) {
    el.append(x);
  } else {
    pos.after(x);
  }

  if (!d && pos) {
    var height = $("#operation_" + idx + "_" + idx2).offset().top;
    $('html, body').animate({scrollTop: height}, 800);
  }
  if (!$('input[name="vqmod_show_trim"]').is(':checked')) $('.vqtrim', $(x)).fadeOut();
  if (!$('input[name="vqmod_show_regex"]').is(':checked')) $('.vqregex', $(x)).fadeOut();
  if (!$('input[name="vqmod_show_info"]').is(':checked')) $('.vqinfo', $(x)).fadeOut();
  if (!$('input[name="vqmod_show_test"]').is(':checked')) $('.vqtest', $(x)).fadeOut();
  if (!d || pos) {
    loadCodeArea(idx + '_' + idx2);
  }
}

function addModFile() {
  var file = $('#file_new_mod').val();
  if (file.indexOf('.') == -1) {
    if (!confirm('<?php echo $warning_no_file_selected;?>')) {
      return false;
    }
  }
  $('#file_new_mod').val(file.replace(/\\/g, '/').replace(/\/[^\/]*\/?$/, '') + '/'); // set current dir
  if ($('input[value="' + file + '"]', '#mod-files').length > 0) { // already added
    return false;
  }
  var fid = $('.mod-files').length;
  var x = '<div id="mod-file' + fid + '" class="mod-files"><i class="fa fa-minus-circle" onclick="$(this).parent().remove();"></i> ' + file;
  x += '<input type="hidden" name="mod_files[]" value="' + file + '" /></div>';
  $('#mod-files').append(x).animate({ scrollTop: $('#mod-files').prop('scrollHeight') - $('#mod-files').height() }, 500);
}

function unCDATA(str) {
  str = String(str).replace("<![CDATA[","").replace("]]>","").replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  //Restore leading newlines (Textarea ignores the first newline)
  if (str.indexOf('\n') === 0 || str.indexOf('\r\n') === 0) str = '\n' + str;
  return str;
}

// SHOW and HIDE FILES and OPERATIONS
var animate = true;
$('#content').on('click', '.arrow', function() {
	var title = ($(this).hasClass(arw + 'down')) ? '<?php echo $text_collapse;?>' : '<?php echo $text_expand;?>',
		act = '.' + arw + ($(this).hasClass(arw + 'up') ? 'up' : 'down'),
		dad = $(this).parent();
	if (dad.is(".ma")) {
		title += '<?php echo $text_all_files;?>';
		animate = false;
		$(".fi").find(".arrow" + act).not('.ops').click();
		animate = true;
	} else if ($(this).hasClass('ops')) {
		title += '<?php echo $text_all_operations;?>';
		animate = false;
		$(this).closest('.file').find('.operation ' + act).click();
		animate = true;
	} else if (dad.is(".fi")) {
		title += '<?php echo $text_this_file;?>';
		if (animate) {
			$(this).closest('.file').find('.operation').slideToggle();
		} else {
			if (act == '.' + arw + 'up') $(this).closest('.file').find('.operation').hide();
			else $(this).closest('.file').find('.operation').show();
		}
		if (act !== '.' + arw + 'up') dad.find('.ops').fadeIn();
		else dad.find('.ops').fadeOut();
		var file = $(this).closest('.file').attr('id').replace('files_', '');
		if (!$('#file_' + file).hasClass('ui-autocomplete-input')) loadAutocomplete(file, !$(this).parent().hasClass('newfi'));
		if (!$('#path_' + file).hasClass('ui-autocomplete-input')) loadPathcomplete(file);
	} else if (dad.is('.modpack')) {
		if (!$('#file_new_mod').hasClass('ui-autocomplete-input')) loadAutocomplete('new_mod', true);
    dad.find('.collapseme').slideToggle();
    if (typeof(codeMirrors['mod_sql']) == 'undefined') loadCodeArea('mod_sql');
    if (typeof(codeMirrors['mod_php']) == 'undefined') loadCodeArea('mod_php');
	} else {
		title += '<?php echo $text_this_operation;?>';
		if (animate) {
			$(this).parent().find('.collapseme').slideToggle();
		} else {
			if (act == '.' + arw + 'up') $(this).parent().find('.collapseme').hide();
			else $(this).parent().find('.collapseme').show();
		}
		var file = $(this).closest('.operation').attr('id').replace('operation_', '');
		if ($('#operation_' + file).find('.vqtest').html() == '' && $('input[name="vqmod_show_test"]').is(':checked')) $('#search_' + file).keyup();
		if ($('#operation_' + file).find('.CodeMirror').length <= 0) loadCodeArea(file);
	}
	$(this).toggleClass(arw + 'up').toggleClass(arw + 'down');
	$(this).attr('data-original-title', title);
});

$('#content').on('click', '.remover', function() {
	var idf = $(this).closest('.file, .operation').attr('id').split('_');
	var ido = (typeof (idf[2]) != 'undefined') ? idf[2] : false;
	idf = idf[1];
	var hide = $('.removeme, .operation', $('#files_' + idf));
  var color = $('#color_file').val(), bcolor = ficolor;
  $(this).toggleClass('fa-minus-circle').toggleClass('fa-undo');
	if (ido) {
		$('#operation_' + idf + '_' + ido).toggleClass('removed');
		hide = $('#operation_' + idf + '_' + ido).find('.collapseme, .arrow');
		if ($('.operation', '#files_' + idf).not('.removed').length === 0) {
			$('.remover:first', '#files_' + idf).click();
		}
    color = $('#color_oper').val(), bcolor = opcolor;
	} else {
		$('#files_' + idf).toggleClass('removed');
	}
	if ($(this).hasClass('fa-undo') && hide.is(':visible')) {
		hide.fadeOut();
		$(this).closest('fieldset').animate({'background-color': '#FFDEDE', 'border-color': '#800000'}, 500);
	} else if ($(this).hasClass('fa-minus-circle') && hide.is(':hidden')) {
		hide.fadeIn();
		$(this).closest('fieldset').css({'background-color': color, 'border-color': bcolor});
	}
});

// SHOW and HIDE STUFF THAT IS VQMOD or OCMOD or INCOMPATIBLE
$('#content').on('change', '#mod_type', function() {
  var type = $(this).val().substring(0,5), pack = $(this).val().length > 5;
  if (type == 'vqmod') {
    //$('.mod-pack').html('.vqmod.' + (pack ? 'zip' : 'xml'));
    $('.vq-only').fadeIn();
    $('.oc-only').fadeOut();
    $('.oc-noregex:hidden').fadeIn();
    $('#vqmver').blur(); // Check vQMod version stuff
  } else {
    //$('.mod-pack').html('.ocmod.' + (pack ? 'zip' : 'xml'));
    $('.vq-only').fadeOut();
    $('.oc-only').fadeIn();
  }
  if (pack) {
    $('#modpack:hidden').slideDown();
  } else {
    $('#modpack:visible').slideUp();
  }
});

$('#content').on('change', '.ignoreif', function() {
	var vqmversion = parseInt($('#vqmver').val().split('.').join(''));
	var ignore = $('#' + $(this).attr('id').replace('ignore_', 'ignoreif_'));
	if ($(this).is(':checked')) {
		if (vqmversion < 230) {
			alert('<?php echo $text_ignoreif_needs;?>' + $('#vqmver').val().replace('v', ''));
			$(this).click();
		} else if (ignore.is(':hidden')) {
			ignore.parent().parent().slideDown();
		}
	} else {
		if (ignore.is(':visible')) ignore.parent().parent().slideUp();
	}
});

$('#content').on('change', '.regex', function() {
	if ($('#vqmver').is(':hidden') && $(this).is(':checked')) {
    $('.oc-noregex:visible', $(this).closest('.operation')).fadeOut();
  } else {
    $('.oc-noregex:hidden', $(this).closest('.operation')).fadeIn();
  }
});

$('#content').on('change', 'select[id^="position_"]', function() {
	var disable = $('#' + $(this).attr('id').replace('position', 'search')),
		offset = $('#' + $(this).attr('id').replace('position', 'offset')).closest('.vqrow'),
		parent = $(this).closest('.op'),
		sel = $('option:selected', $(this)).val();
	if (!$('#vqmver-required').is(':checked') && (sel == 'ibefore' || sel == 'iafter')) $('#vqmver-required').click();
	if (sel == 'top' || sel == 'bottom' || sel == 'all') {
		var oldval = disable.val();
		if (oldval !== '<?php echo $text_top;?>' && oldval !== '<?php echo $text_bottom;?>' && oldval !== '<?php echo $text_all;?>') {
			disable.data('oldval', oldval);
		}
		value = (sel == 'top') ? '<?php echo $text_top;?>' : ((sel == 'bottom') ? '<?php echo $text_bottom;?>' : '<?php echo $text_all;?>');
		disable.val(value);
		disable.attr('readonly', 'readonly').css('color', '#AAA');
		if ($('.hideonall:first', parent).is(':visible')) $('.hideonall', parent).fadeOut();
		if (sel == 'all') {
			if (offset.is(':visible')) offset.fadeOut();
		} else {
			if (offset.is(':hidden')) offset.fadeIn();
		}
	} else if (disable.is('[readonly]')) {
		disable.val(disable.data('oldval'));
		disable.removeAttr('readonly').css('color', '');
		if ($('.hideonall:first', parent).is(':hidden')) $('.hideonall', parent).fadeIn();
		if (offset.is(':hidden')) offset.fadeIn();
	}
});

	$('#vqmver').blur(function() {
		var vqmversion = parseInt($(this).val().split('.').join('')), required = $('#vqm-required:visible');
		if (vqmversion >= 230) {
			$('.vqm230').show();
			$('textarea[id^="ignoreif_"]').each(function() {
				var ignore = $('#' + $(this).attr('id').replace('if', ''));
				if ($(this).val() && !ignore.is(':checked')) ignore.click(); // Show IgnoreIf fields
        else if (!$(this).val() && !ignore.is(':checked')) $(this).closest('.vqrow').fadeOut();
			});
			$('input[id^="path_"]:hidden').fadeIn();
			if (vqmversion >= 240) {
				$('#vqm-required:hidden').fadeIn();
				$('.vqm240').show();
			} else {
				if (required.length >= 1) {
					if (required.is(':checked')) required.click();
					required.fadeOut();
				}
				$('.vqm240').hide();
			}
		} else {
			$('input[id^="path_"]:visible').fadeOut();
			if (required.length >= 1) {
				if (required.is(':checked')) required.click();
				required.fadeOut();
			}
			$('.ignoreif:checked').click(); // Hide IgnoreIf fields
			$('.vqm230, .vqm240').hide();
		}
	});

$('input.mod-add-install').change(function() {
  var id = $(this).attr('id');
  var idx = id.replace('add_', '');
  if (typeof(codeMirrors[idx]) == 'undefined') loadCodeArea(idx);
  $('.' + id).slideToggle();
});

  // Trigger some filters
  $('#vqmver').blur();

  $('#mod_type').change();

	$('input[id^="file_"]').keyup();

	$('select[id^="position_"]').change();

// INPUT CORRECTIONS
$('#content').on('keyup', 'input.numeric', function() {
	var value = $(this).val().replace(/[A-Za-z $-$=]/g, "");
	$(this).val(value);
});

var t = {};
$('#content').on('keyup', 'input[id^="search_"], textarea[id^="ignoreif_"]', function() {
  if ($('input[name="vqmod_show_test"]').is(':checked')) {
		var sId = $(this).attr('id').split('_');
		var file = $('#path_' + sId[1]).val() + $('#file_' + sId[1]).val(),
			search = $(this),
			name = 'search' + sId[1] + '_' + sId[2],
			regex = ($('input[name="' + (sId[0] === 'search' ? 'regex' : 'regif') + '[' + sId[1] + '][' + sId[2] + ']"').is(':checked')) ? '&regex=1' : '';
		if (search.val() != '' && file != '') {
			var vqtest = search.closest('.operation').find('.vqtest');
			vqtest.html('');
			if (t[name]) clearTimeout(t[name]);
			var checksearch = function() {
				$.ajax({
					url : '<?php echo html_entity_decode($link_test_search);?>' + regex,
					type: 'POST',
					dataType: 'json',
					data: {'search': search.val(), 'file': file},
					success: function(found) {
						if (!found) {
							vqtest.html('<?php echo $text_search_not_found;?>');
						} else {
							var times = '';
							for (var i in found) {
								var file = (found[i] === 'no file') ? '<?php echo $text_search_not_file;?>' : (!found[i] ? '<?php echo $text_search_not_found;?>' : (found[i] === 1 ? '<?php echo $text_search_found;?>' : '<?php echo $text_search_founds;?>'));
								if (times !== '') times += '<br/>';
								times += '<b>' + i + '</b>: ' + file.replace('%s', found[i]);
							}
							if (times === '') return;
							vqtest.html(times);
						}
						if (vqtest.is(':hidden') && vqtest.closest('.operation').find('.' + arw + 'up').length >= 1) vqtest.fadeIn('slow');
						if (sId[0] === 'search') vqtest.addClass('search').removeClass('ignoreif').css('background-color', '#FFFFFF');
						else vqtest.removeClass('search').addClass('ignoreif').css('background-color', '#F8FFCB');
					}
				});
			};
			t[name] = setTimeout(checksearch, 800);
		}
  }
}).focus(function () {
	var sId = $(this).attr('id').split('_'), vqtest = $(this).closest('.operation').find('.vqtest');
	if (!vqtest.hasClass(sId[0])) $(this).keyup();
});
$('#content').on('keyup', 'input[name^="index["]', function() {
	$(this).attr('size', $(this).val().length);
});

// AUTOCOMPLETE STUFF
function loadAutocomplete(id, files) {
	files = files ? '' : '&files=0';
  $('#file_' + id).autocomplete({
		delay: 500,
		minLength: 0,
		source: function(request, response) {
			var ocmod = ($('#mod_type').val().substring(0,5) == 'ocmod' && id != 'new_mod') ? '&ocmod=1' : '';
			var path = (id != 'new_mod') ? $('#path_' + id).val() : '&ext=all';
			var term = path + request.term + ocmod;
			if (term in cache) {
				response(cache[term]);
				return;
			}
			$.ajax({
				url: '<?php echo html_entity_decode($link_autocompl); ?>&path=' + path + files + ocmod + '&dir=' + encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					cache[term] = json;
					response(json);
				}
			});
		},
		select: function(event, ui) {
			if (ui.item.value.indexOf('*') != -1) {
				var file = $(this).attr('id');
				if ($('.file_error_' + file).is(':visible')) $('.file_error_' + file).fadeOut();
			}
		}
	}).keyup(function() {
		var dir = $(this).val().toLowerCase().split('.'), ext = '';
		if (dir.length > 1) {
			ext = dir[dir.length-1];
		}
		if (ext.length === 3 && ext !== 'php' && ext !== 'tpl') $(this).css('background-color', '#ffbebe');
		else $(this).css('background-color', '');
	}).blur(function() {
		var val = $(this).val();
		if (val && (val.indexOf('/') === 0 || val.indexOf('\\') === 0)) val = val.substr(1);
	});
}
function loadPathcomplete(id) {
	$('#path_' + id).autocomplete({
		delay: 500,
		minLength: 0,
		source: function(request, response) {
			var term = request.term + '-p';
			if (term in cache) {
				response(cache[term]);
				return;
			}
			$.ajax({
				url: '<?php echo html_entity_decode($link_autocompl); ?>&files=0&dir=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					cache[term + '-p'] = json;
					response(json);
				}
			});
		},
    select: function(event, ui) {
			var id = $(this).attr('id').replace('path_', '');
			if (ui.item.value.indexOf('*') !== -1) {
				if ($('.file_error_' + id).is(':visible')) $('.file_error_' + id).fadeOut();
			}
			if (ui.item.value.length) {
				var width = 1, path = $('#path_' + id), file = $('#file_' + id);
				width = ui.item.value.length;
				path.attr('size', width);
				width = file.parent().outerWidth(false) - path.outerWidth(true) - 68;
				file.css('width', width);
			}
		}
	}).blur(function() {
		var val = $(this).val();
		if (val) {
			if (val.indexOf('/') === 0 || val.indexOf('\\') === 0) val = val.substr(1);
			if (val.substr(val.length -1) === '\\') val = val.substr(0, val.length -1);
			if (val.substr(val.length -1) !== '/') val += '/';
		}
	});
}
$('#content').on('keyup', 'input[id^="file_"]', function() {
	var vqmversion = $('#vqmver').is(':hidden') ? false : parseInt($('#vqmver').val().split('.').join('')), value = $(this).val();
	if (value.indexOf(' ') != -1) value = value.replace(' ', '');
	if (value.indexOf(',') != -1 && vqmversion < 230 && $('#mod_type').val().indexOf('ocmod') != -1) value = value.replace(',', '');
	var file = $(this).attr('id').replace('file_', '');
	if (value.indexOf('*') >= 0) {
		if ($(".file_error_" + file).is(':visible')) $(".file_error_" + file).fadeOut();
	} else {
		if ($(".file_error_" + file).is(':hidden') && $('#path_' + file).val().indexOf('*') == -1 && $('#mod_type').val().substring(0,5) != 'ocmod') $(".file_error_" + file).fadeIn();
	}
	$(this).val(value);
}).on('click', 'input[id^="file_"]', function() {
	var file = $(this).attr('id').replace('file_', '');
  if (!$(this).hasClass('ui-autocomplete-input')) loadAutocomplete(file, !$(this).parent().hasClass('newfi'));
	var vqmversion = parseInt($('#vqmver').val().split('.').join(''));
	var path = $('#path_' + file).val(), value = $(this).val();
	if (vqmversion >= 230 && value.indexOf(path) === 0) {
		$(this).val(value.replace(path, ''));
	} else if (vqmversion < 230 && path != '' && value.indexOf(path) !== 0) {
		$(this).val(path + value);
		$('#path_' + file).val('');
	}
	$(this).autocomplete('search');
});
$('#content').on('keyup', 'input[id^="path_"]', function() {
	var value = $(this).val();
	if (value.indexOf(' ') >= 0) value = value.replace(' ', '');
	if (value.indexOf(',') >= 0) value = value.replace(',', '');
	var file = $(this).attr('id').replace('path_', '');
	if (value.indexOf('*') >= 0) {
		if ($('.file_error_' + file).is(':visible')) $('.file_error_' + file).fadeOut();
	} else {
		if ($('.file_error_' + file).is(':hidden') && $('#file_' + file).val().indexOf('*') == -1) $('.file_error_' + file).fadeIn();
	}
	$(this).val(value);
}).on('click', 'input[id^="path_"]', function() {
	var file = $(this).attr('id').replace('path_', '');
	if (!$(this).hasClass('ui-autocomplete-input')) loadPathcomplete(file);
	$(this).autocomplete('search');
});

var codeMirrors = {};
function loadCodeArea(id) {
  codeMirrors[id] = CodeMirror.fromTextArea(document.getElementById('add_' + id), {
    mode: 'text/x-php',
    matchBrackets: true,
    indentUnit: 2,
    indentWithTabs: true,
    lineWrapping: true,
    enterMode: "keep"
  });
  codeMirrors[id].setSize('100%', $('input[name="vqmod_text_height"]').val() + 'px');
}

// SAVE XML FUNCTIONS
function makeXML() {
  var name    = "<name>";
  var vqmod = $('#mod_type').val().substring(0,5) == 'vqmod';

  var xml = "<modification";
  if (vqmod) {
    name = "<id>";
    xml += " xmlns=\"https://github.com/vqmod/vqmod\"";
    xml += " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"";
    xml += " xsi:schemaLocation=\"https://github.com/vqmod/vqmod https://raw.githubusercontent.com/vqmod/vqmod/master/vqmod.xsd\"";
  }
  xml += ">";
  xml = $(xml);
  xml.append("\n\t").append($(name, { text: "<![CDATA[" + $("#name").val() + "]]>" }));
  xml.append("\n\t").append($("<version>", { text: $("#version").val() }));
  if (vqmod) xml.append("\n\t").append("<vqmver" + ($('#vqmver-required:visible').is(':checked') ? ' required="true"' : '') + ">" + $("#vqmver").val() + "</vqmver>");
  xml.append("\n\t").append($("<author>", { text: "<![CDATA[" + $("#author").val() + "]]>" }));
  xml.append("\n\t").append($("<code>", { text: $("#code").val() }));
  xml.append("\n\t").append($("<description>", { text: "<![CDATA[" + $("#description").val() + "]]>" }));
  xml.append("\n\n");

  $(".file").not('.removed').each(function() {
    var id = $(this).attr('id').replace('files_', '');
    xml.append("\t").append(makeFileXML(id, vqmod)).append("\n\n");
  });

  return $("<textarea />").append(xml).html();
}

function makeFileXML(id, vqmod) {
  var path = $("#path_" + id + ":visible").val();
  path = (path && vqmod) ? 'path="' + path + '" ' : '';
  var name = (vqmod ? path + 'name="' : 'path="') + $("#file_" + id).val() + '"';
  if (vqmod) name += ' error="' + $("#error_" + id).val() + '"';
  var file = $("<file " + name + ">");

  $('.operation', '#files_' + id).not('.removed').each(function() {
    var id = $(this).attr('id').replace('operation_', '');
    file.append("\n\t\t").append(makeOperationXML(id, vqmod)).append("\n\t");
  });

  return file;
}

function makeOperationXML(id, vqmod) {
  var error = (vqmod) ? ' error="' + $("#error_" + id).val() + '"' : '';
  var info = $("#info_" + id).val();
  if (info !== '') error += ' info="' + info + '"';
  var operation = $("<operation" + error + ">");
  var ignore = $("#ignoreif_" + id).val();
  if (vqmod && ignore !== '') {
    operation.append("\n\t\t\t").append($("<ignoreif />", { text: "<![CDATA[" + ignore + "]]>" }).attr({ 'regex': $("#regif_" + id).is(':checked') }));
  }

  var action = $("#position_" + id).val();
  var index = $("#index_" + id).val();
  var offset = $("#offset_" + id).val();
  var regex = $("#regex_" + id).is(':checked');
  var limit = $("#limit_" + id).val();
  var trims = $("#trims_" + id).is(':checked');
  var search = "<![CDATA[" + $("#search_" + id).val() + "]]>";
  var trim = $("#trim_" + id).is(':checked');
  var add = "<![CDATA[" + $("#add_" + id).val() + "]]>";

  var search = $("<search />", { text: search });
  var add = $("<add />",{ text: add });

  if (vqmod) {
    search.attr('position', action);
    if (index) search.attr('index', index);
    if (!trims) search.attr('trim', trims);
    if (offset != 0) search.attr('offset', offset);
    if (regex) search.attr('regex', regex);
  } else {
    if (index) search.attr('index', index);
    if (limit) search.attr('limit', limit);
    search.attr('trim', trims);
    if (!regex) {
      add.attr({ 'position': action, 'trim': trim });
      if (offset != 0) add.attr('offset', offset);
    } else {
      search.attr({ 'regex': regex });
    }
  }
  return operation.append("\n\t\t\t").append(search).append("\n\t\t\t").append(add).append("\n\t\t");
}

  // AutoSave
  var interval;
	$("#autosave").focus(function() {
		$(this).val('');
		clearInterval(interval);
	}).blur(function() {
		if ($(this).val()) {
			var seconds = parseFloat($(this).val());
			$(this).data('oldval', seconds);
			seconds *= 60;
			var rr = '|';
			interval = setInterval(function () {
				if (seconds <= 0) {
					seconds = parseFloat($("#autosave").data('oldval')) * 60;
					$('.save-continue:first').click();
				}
				$("#autosave").val(Math.round(seconds) + ' <?php echo $text_seconds_togo;?>  ' + rr + ' ' + rr + ' ' + rr);
				rr = (rr == '|') ? '/' : (rr == '/' ? '-' : (rr == '-' ? '\\' : '|'));
				seconds -= 0.2;
			}, 200);
		} else {
			clearInterval(interval);
			$(this).val('');
		}
	});

// SETTINGS DIALOG
$('.mod-config').click(function() {
  $('.alert').fadeOut(300, function() { $('.alert').remove(); });
  $('#mod-config').dialog({
    title: '<?php echo $text_mod_config;?>',
    autoOpen: true,
    width: '750',
    height: '550',
    open: function() {
      loadPathcomplete('mod_test');
    },
    buttons: [{
      text: '<?php echo $button_save;?>',
      click: function() {
        $.ajax({
          url : '<?php echo html_entity_decode($link_config);?>',
          type: 'POST',
          data: $('input, textarea', '#mod-config'),
          dataType: 'json',
          success: function(data) {
            $(':input', '#mod-config').each(function() {
              var orig = $(this).val();
              if ($(this).is(':checkbox')) {
                if (!$(this).is(':checked')) orig = 0;
              }
              $(this).data('orig', orig);
            });
            var div = $('<div/>').hide();
            if (data.success) {
              div.addClass('alert alert-success').html('<i class="fa fa-check-circle"></i> ' + data.success + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
            } else {
              div.addClass('alert alert-danger').html('<i class="fa fa-exclamation-circle"></i> ' + data.warning + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
            }
            $('.errors').prepend(div);
            div.fadeIn(400);
            $('#mod-config').dialog('close');
          }
        });
      }
    },{
      text: '<?php echo $button_cancel;?>',
      click: function() {
        $(':input', '#mod-config').each(function() {
          var orig = $(this).data('orig');
          if ($(this).is(':checkbox')) {
            var checked = $(this).is(':checked');
            if (checked && orig == '0') $(this).click();
          } else {
            $(this).val(orig);
            $(this).keyup();
          }
        });
        if (!$('input[name="vqmod_show_trim"]').is(':checked')) $('.vqtrim').fadeOut();
        if (!$('input[name="vqmod_show_regex"]').is(':checked')) $('.vqregex').fadeOut();
        if (!$('input[name="vqmod_show_info"]').is(':checked')) $('.vqinfo').fadeOut();
        if (!$('input[name="vqmod_show_test"]').is(':checked')) $('.vqtest').fadeOut();
        $(this).dialog('close');
      }
    }]
  });
});
$('input:checkbox[name^="vqmod_show_"]').change(function() {
  var name = $(this).attr('name').replace('vqmod_show_', '');
  if ($(this).is(':checked')) {
    $(this).val('1');
    $('.vq' + name).fadeIn();
  } else {
    $(this).val('0');
    $('.vq' + name).fadeOut();
  }
});
$('input:checkbox[name="vqmod_updates"]').change(function() {
  if ($(this).is(':checked')) {
    $(this).val('1');
  } else {
    $(this).val('0');
  }
});
$('input[name="vqmod_text_height"]').keyup(function() {
  var value = $(this).val().replace(/[A-Za-z$-]/g, "");
  $(this).val(value);
  $('.CodeMirror').animate({height: value + 'px'}, 800);
});
$('#path_mod_test').on('click', function() {
  $(this).autocomplete('search');
});

// COLOR CALCULATOR
function ColorLuminance(hex, lum) {
	hex = String(hex).replace(/[^0-9a-f]/gi, '');
	if (hex.length < 6) {
		hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
	}
	lum = lum || 0;
	var rgb = "#", c, i;
	for (i = 0; i < 3; i++) {
		c = parseInt(hex.substr(i*2,2), 16);
		c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
		rgb += ("00"+c).substr(c.length);
	}
	return rgb;
}

$('.vqcolor').keyup(function() {
  var color = $(this).val();
  if (color.substring(0,1) !== '#') {
    color = '#' + color;
    $(this).val(color);
  }
  if (color.length > 7) {
    $(this).val(color.substring(0,7));
  }
  if (/^#[a-zA-Z0-9]{6}$/.test(color)) {
    var border = ColorLuminance(color, -0.4);
    var id = $(this).attr('id');
    $(this).css({ 'background-color': color, 'border-color': border });
    $('.' + id).css({ 'background-color': color, 'border-color': border });
    if (id == 'color_file') ficolor = border;
    if (id == 'color_oper') opcolor = border;
  }
}).change(function() { $(this).keyup(); });
$('.vqcolor').keyup();

// UPLOAD SCRIPT (TAKEN FROM DOWNLOAD.PHP)
$('#button-upload').on('click', function() {
	var dest = $('#file_new_mod').val();
  if (dest.indexOf('.') != -1) {
    alert("<?php echo $error_file_selected;?>");
    return false;
  }
  var destdir = dest ? dest : 'Store Root Folder';
  if (!confirm("<?php echo $text_confirm_upload;?>\n" + destdir)) {
    return false;
  }

  $('#form-upload').remove();
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /><input type="text" name="dest" value="' + dest + '" /></form>');
  $('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
   	clearInterval(timer);
	}
	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: '<?php echo html_entity_decode($link_upload);?>',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$('#button-upload').html('Loading');
				},
				complete: function() {
					$('#button-upload').html('<?php echo $button_upload;?>');
				},
				success: function(json) {
					if (json['error']) {
						alert(json['error']);
					}

					if (json['success']) {
						alert(json['success']);
						$('#file_new_mod').val(json['file']);
            addModFile();
					}
				},			
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

// OVERRIDE CTRL+S or CMD+S - WILL NOW SAVE THE MODIFICATION
$(window).keydown(function(event) {
  if ((event.ctrlKey || event.metaKey) && String.fromCharCode(event.which).toLowerCase() == 's') {
	$('.save-continue:first').click();
    event.preventDefault();
    return false;
  }
});
/**
 * Copyright 2012, Digital Fusion
 * Licensed under the MIT license.
 * http://teamdf.com/jquery-plugins/license/
 *
 * @author Sam Sehnert
 * @desc A small plugin that checks whether elements are within
 *		 the user visible viewport of a web browser.
 *		 only accounts for vertical position, not horizontal.
 */
$.fn.visible = function(partial) {
	var $t				= $(this),
		$w				= $(window),
		viewTop			= $w.scrollTop(),
		viewBottom		= viewTop + $w.height(),
		_top			= $t.offset().top,
		_bottom			= _top + $t.height(),
		compareTop		= partial === true ? _bottom : _top,
		compareBottom	= partial === true ? _top : _bottom;
	return ((compareBottom <= viewBottom) && (compareTop >= viewTop));
};
$('.prev-collapse').click(function() {
	$('.operation').each(function() {
		if (!$(this).visible(false)) { // Hide if not totally visible
			$(this).find('.arrow.' + arw + 'up').click();
		}
	});
});
//--></script>

<?php echo $footer; ?>