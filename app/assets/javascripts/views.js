$(function () {
    var check_img_ts = $('#upload-file-input');
    if (check_img_ts.length > 0) {
        check_img_ts.bind('change', function () {
            var this_file = this.files[0];
            var file_name = this_file.name;
            var file_type = file_name.substring(file_name.lastIndexOf(".") + 1);
            var preview_image = $("#preview-image");
            var has_error = (check_file_type(this, ['jpg', 'jpeg', 'png'], file_type) && check_file_size(this, 2, this_file.size));
            if (!has_error) {
                preview_image.addClass('hide');
                return false;
            }
            var windowURL = window.URL || window.webkitURL;
            var dataURL;
            preview_image.removeClass('hide');
            dataURL = windowURL.createObjectURL(this_file);
            document.getElementById("preview-image").innerHTML = '<img src="' + dataURL + '"  width="320" height="240">';
        });
    }


    $('.upload-photo').click(function (event) {
        event.preventDefault();
        var form = $("#new_photo");
        if (window.FormData !== undefined) {
            var postData = new FormData(form[0]);
            $.ajax({
                // url: form.attr('action'),
                url:'/photos',
                type: "POST",
                dataType: "json",
                data: postData,
                processData: false,
                contentType: false,
                success: function (data) {
                    console.log(data);
                },
                error: function (data) {
                    console.log(data);
                }
            });
        } else {
            form.submit();
        }
    });
});
function check_file_type(obj, limit_type, file_type) {
    if ($.inArray(file_type, limit_type) == -1) {
        alert('文件格式不规范,请上传 ' + limit_type.join('、') + ' 格式的文件');
        obj.value = '';
        return false;
    } else {
        return true;
    }
}

function check_file_size(obj, limit_size, file_size) {
    var size = file_size / 1024 / 1024;
    if (size > limit_size) {
        alert("文件大小不能大于" + limit_size + "M，请重新选择");
        obj.value = '';
        return false;
    } else {
        return true;
    }
}
