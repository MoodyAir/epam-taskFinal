<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="epam.zlatamigas.surveyplatform.controller.command.CommandType" %>
<%@ page import="epam.zlatamigas.surveyplatform.controller.navigation.DataHolder" %>
<%@ page import="epam.zlatamigas.surveyplatform.model.entity.SurveyStatus" %>
<%@ page import="epam.zlatamigas.surveyplatform.model.entity.UserRole" %>

<fmt:setLocale value="${sessionScope.localisation}" scope="session"/>
<fmt:setBundle basename="localisation.localisedtext"/>

<c:set var="itemsPerPage" value="10" scope="page"/>

<!DOCTYPE html>
<html lang="${sessionScope.localisation}">
<head>
    <title><fmt:message key="title.themes.confirmed"/></title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="${pageContext.request.contextPath}/static/js/pagination.js"></script>
</head>

<body>

<jsp:include page="/view/fragment/header.jsp"/>

<div class="container-fluid">

    <div class="row">
        <div class="col-3">
            <jsp:include page="/view/fragment/account_left_navbar.jsp"/>
            <script>
                document.getElementById("collapseTheme").classList.add("show");
                document.getElementById("navThemesConfirmed").classList.add("active");
                document.getElementById("navThemes").setAttribute("disabled", "disabled");
            </script>
        </div>
        <div class="col-9">
            <div class="content-container">

                <div id="themesContainer" class="hide-on-popup">

                    <button id="showAddTheme" class="btn btn-create"><fmt:message key="button.create"/></button>

                    <div class="search-container">
                        <form action="controller" method="get">
                            <input type="hidden" name="${DataHolder.PARAMETER_COMMAND}" value="${CommandType.SEARCH_THEMES_CONFIRMED}">
                            <div class="form-row row-search">
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="<fmt:message key="placeholder.search"/>" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_SEARCH_WORDS}" value="${requestScope.search_words}">
                                </div>
                                <div class="col-auto">
                                    <button type="submit" class="btn btn-search"><i class="fa fa-search"></i></button>
                                </div>
                            </div>
                            <div class="form-row justify-content-md-end row-filter">

                                <div class="col-md-3">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text"><i class="fas fa-sort-amount-down"></i></div>
                                        </div>
                                        <select id="order" class="form-control" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_ORDER_TYPE}">
                                            <option value="ASC" <c:if test="${requestScope.order_type == 'ASC'}">selected</c:if>><fmt:message key="order.asc"/></option>
                                            <option value="DESC" <c:if test="${requestScope.order_type == 'DESC'}">selected</c:if>><fmt:message key="order.desc"/></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="pagination-page-container">
                        <div id="pagination-page-container">
                            <c:set var="themePage" value="1" scope="page"/>
                            <div id="pagination-page-${themePage}" style="display: none">
                            <c:if test="${requestScope.requested_themes != null && requestScope.requested_themes.size() > 0}">
                                <c:forEach var="themeIndex" begin="0" end="${requestScope.requested_themes.size() - 1}">
                                    <c:set var="theme" value="${requestScope.requested_themes.get(themeIndex)}" scope="page"/>
                                    <c:if test="${themeIndex / itemsPerPage >= themePage}">
                                        </div>
                                        <c:set var="themePage" value="${themePage + 1}"/>
                                        <div id="pagination-page-${themePage}" style="display: none">
                                    </c:if>
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="row justify-content-between">
                                                    <div class="col">
                                                        <h5>${theme.themeName}</h5>
                                                    </div>
                                                    <div class="col col-auto">
                                                        <form action="controller" method="post">
                                                            <input type="hidden" name="${DataHolder.PARAMETER_COMMAND}" value="${CommandType.DELETE_THEME}">
                                                            <input type="hidden" name="${DataHolder.PARAMETER_THEME_ID}" value="${theme.themeId}">
                                                            <input type="hidden" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_SEARCH_WORDS}" value="${requestScope.search_words}">
                                                            <input type="hidden" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_ORDER_TYPE}" value="${requestScope.order_type}">
                                                            <button class="btn btn-danger" type="submit"><i class="fas fa-trash"></i></button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <c:remove var="theme" scope="page"/>
                                    </c:forEach>
                                    </c:if>
                                    </div>
                            <c:remove var="themePage" scope="page"/>
                            </div>
                    </div>

                    <div class="pagination">
                        <ul></ul>
                    </div>

                    <script>
                        const element = document.querySelector(".pagination ul");
                        let totalPages = Math.max(Math.ceil(${requestScope.requested_themes.size() / itemsPerPage}), 1);
                        let page = 1;
                        element.innerHTML = createPagination(totalPages, page);
                    </script>

                </div>

                <div id="addThemePopup" class="popup">
                    <div class="close-btn"><i class="fas fa-times"></i></div>
                    <form action="controller" method="post">
                        <h2><fmt:message key="label.survey.theme"/> </h2>
                        <div class="form-row">
                            <input type="hidden" name="${DataHolder.PARAMETER_COMMAND}" value="${CommandType.ADD_THEME}">
                            <div class="col">
                                <div id="themeValidationFeedback" class="text-danger">
                                    <p>
                                        <c:if test="${requestScope.form_invalid.theme_name != null}">
                                            <fmt:message key="${requestScope.form_invalid.theme_name}"/>
                                        </c:if>
                                        <c:if test="${requestScope.theme_exists != null}">
                                            <fmt:message key="${requestScope.theme_exists}"/>
                                        </c:if>
                                    </p>
                                </div>
                                <input type="hidden" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_SEARCH_WORDS}" value="${requestScope.search_words}">
                                <input type="hidden" name="${DataHolder.REQUEST_PARAMETER_ATTRIBUTE_ORDER_TYPE}" value="${requestScope.order_type}">
                                <input id="inputThemeName" type="text" name="${DataHolder.PARAMETER_THEME_NAME}" class="form-control">
                            </div>
                        </div>
                        <div class="form-row justify-content-end">
                            <div class="col-auto">
                                <button type="submit" class="btn btn-success"><fmt:message key="button.add"/></button>
                            </div>
                        </div>
                    </form>
                </div>
                <script>
                    <c:if test="${(requestScope.form_invalid.theme_name != null) || (requestScope.theme_exists != null)}">
                    document.querySelector("#addThemePopup").classList.add("active");
                    document.querySelector("#themesContainer").classList.add("active");
                    </c:if>

                    document.querySelector("#showAddTheme").addEventListener("click", function (){
                        document.querySelector("#addThemePopup").classList.add("active");
                        document.querySelector("#themesContainer").classList.add("active");
                        $("#inputThemeName").val("");
                        $("#themeValidationFeedback").hide();
                    });
                    document.querySelector("#addThemePopup .close-btn").addEventListener("click", function (){
                        document.querySelector("#addThemePopup").classList.remove("active");
                        document.querySelector("#themesContainer").classList.remove("active");
                        $("#inputThemeName").val("");
                    });
                </script>

            </div>
        </div>
    </div>
</div>
</body>
</html>
