<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<fmt:setLocale value="${sessionScope.localisation}" scope="session"/>
<fmt:setBundle basename="localisation.localisedtext"/>

<!DOCTYPE html>
<html lang="${sessionScope.localisation}">
<head>
    <title><fmt:message key="title.addsurvey"/></title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <form action="controller" method="POST">

        <input type="hidden" name="command" value="save_survey">

        <div class="form-group">
            <label for="surveyName">Survey name</label>
            <input type="text" class="form-control" id="surveyName" minlength="1" maxlength="200"
                   value="${sessionScope.current_survey.name}">
        </div>

        <div class="form-group">
            <label for="surveyTheme">Theme</label>
            <select id="surveyTheme" class="form-control">
                <c:forEach items="${sessionScope.themes}" var="theme">
                    <c:choose>
                        <c:when test="${theme.themeId != sessionScope.current_survey.theme.themeId}">
                            <option value="${theme.themeId}">${theme.themeName}</option>
                        </c:when>
                        <c:otherwise>
                            <option selected value="${theme.themeId}">${theme.themeName}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="surveyDescription">Description</label>
            <textarea class="form-control" id="surveyDescription"
                      rows="3">${sessionScope.current_survey.description}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <hr>


    <c:forEach items="${sessionScope.current_survey.questions}" var="question">
        <div class="card">
            <div class="card-header">

                <div class="row justify-content-between">
                    <div class="col">
                        <h5 class="card-title">${question.formulation}</h5>
                    </div>
                    <div class="col col-auto">

                        <form id="startEditQuestionForm" action="controller" method="post">
                            <input type="hidden" name="command" value="start_edit_question">
                            <input type="hidden" name="question_id" value="${question.questionId}">
                        </form>
                        <form id="deleteQuestionForm" action="controller" method="post">
                            <input type="hidden" name="command" value="delete_question">
                            <input type="hidden" name="question_id" value="${question.questionId}">
                        </form>

                        <div class="btn-group" role="group">
                            <button type="submit" form="startEditQuestionForm" class="btn btn-primary">Edit</button>
                            <button type="submit" form="deleteQuestionForm" class="btn btn-warning">Delete</button>
                        </div>
                    </div>
                </div>


            </div>
            <div class="card-body">
                <p class="card-subtitle mb-2 text-muted">Select multiply: ${question.selectMultiple}</p>
                <ul>
                    <c:forEach items="${question.answers}" var="answer">
                        <li class="card-text">${answer.answer}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>


</div>

</body>
</html>