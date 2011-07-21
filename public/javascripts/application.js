/* DO NOT MODIFY. This file was compiled Thu, 21 Jul 2011 18:38:45 GMT from
 * /vault/development/nwn/app/coffeescripts/application.coffee
 */

(function() {
  jQuery(function() {
    $(".rating").each(function() {
      var id;
      id = $(this).attr("id");
      return VK.Widgets.Like(id, {
        type: "button"
      }, id);
    });
    return VK.Observer.subscribe('widgets.like.liked', function(one, two, three, four, five, six) {
      alert('Hell');
      debugger;
    });
  });
  jQuery(function() {
    var callback, id, params;
    id = $(".comments").attr("id");
    callback = function(num, last_comment, date, sign) {
      date = encodeURIComponent(date);
      last_comment = encodeURIComponent(last_comment);
      return $.ajax({
        url: '/vk/comment',
        data: "id=" + id + "&num=" + num + "&last_comment=" + last_comment + "&date=" + date + "&sign=" + sign,
        dataType: 'json',
        type: 'post',
        success: function(result) {}
      });
    };
    params = {
      limit: 20,
      width: "496",
      attach: "*",
      norealtime: 1,
      onChange: callback
    };
    return VK.Widgets.Comments(id, params, id);
  });
}).call(this);
