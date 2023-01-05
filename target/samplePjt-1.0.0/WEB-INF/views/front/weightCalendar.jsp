<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<%@ include file="/WEB-INF/views/header.jsp" %>
<body>
<style>
#calendar { height:600px;width:1000px;position:absolute;top:50%;left:50%;margin-top:-300px;margin-left:-500px;}
.fc-toolbar-chunk {}
</style>

<script>

$(document).ready(function() {
	
	
});

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    fixedWeekCount: false,
    headerToolbar: {
        left: 'prevYear,prev today',
        center: 'title',
        right: 'next,nextYear today'
      },
    dateClick: function() {
               console.log('cell click');
               }
  });
  calendar.render();
});

</script>


<div id='calendar'></div>



</body>
</html>