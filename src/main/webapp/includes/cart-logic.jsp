<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Toast Notification Include -->
    <jsp:include page="toast.jsp" />

    <!-- Cart AJAX JS -->
    <!-- Note: Included in header, so using 'defer' or waiting for DOMContentLoaded in script is crucial (which we already do) -->
    <script src="${pageContext.request.contextPath}/assets/js/cart-ajax.js"></script>