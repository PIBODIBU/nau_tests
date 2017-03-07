<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page import="ua.edu.nau.helper.TimeFormatter" %>
<%@ page import="ua.edu.nau.model.Question" %>
<%@ page import="ua.edu.nau.model.Answer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = (User) request.getAttribute(Attribute.ATTR_USER_MODEL);%>
<%Test test = (Test) request.getAttribute(Attribute.ATTR_TEST_MODEL);%>

<html>
<head>
    <title>Редагувати тест
    </title>

    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/resources/css/fab-menu.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/drawer_style.css" rel="stylesheet">
</head>

<body onload="checkJSPData()">

<style>
    body {
        width: 100%;
        max-width: 100%;
        background: #f9f9f9;
    }

    .page-content {
        width: 100%;
        margin: auto;
        padding-bottom: 24px;
    }

    .mdl-card__actions {
        padding: 0;
    }

    .mdl-textfield {
        width: 100%;
    }

    .mdl-grid {
        width: 100%;
        padding: 24px;
        margin-top: 24px;
    }

    .mdl-cell {
        margin: 0;
    }

    .p-title {
        margin-top: 24px;
    }

    .question-title-cell {
        display: inline-block;
    }

    .question-button-delete {
        display: inline-block;
        margin: initial;
    }

    .page-content {
        width: 70%;
        /* max-width: 70%;
         min-width: 70%;*/
        margin: auto;
    }

    @media screen
    and (max-device-width: 500px)
    and (max-device-height: 800px) {
        .page-content {
            width: 100%;
            /*padding: 24px;*/
            margin: auto;
        }

        .mdl-grid {
            width: 70%;
            /*padding: 24px;*/
            margin-top: auto;
        }

        .p-title {
            margin: 24px;
        }
    }

    .mdl-list__item {
        padding: 0;
    }

    .mdl-radio {
        margin-left: 16px;
    }

    .mdl-list {
        padding: 0;
        margin: 0;
    }
</style>

<script type="text/javascript">
    const PREFIX_ID_GRID = "grid-";
    const PREFIX_ID_CELL = "cell-";
    const PREFIX_ID_TITLE_MAIN_INFO = "title-main-info-";
    const PREFIX_ID_INPUT_WRAPPER = "input-wrapper-";
    const PREFIX_ID_INPUT_ANSWERS_CHECKBOX = "answers-checkbox-";
    const PREFIX_ID_QUESTION_TEXT = "question-text-";
    const PREFIX_ID_QUESTION_IMG_URL = "question-img-url-";
    const PREFIX_ID_ANSWERS_LIST = "answers-list-";

    var counter = 0;
    var answersCounter = 0;

    class Answer {
        constructor(text, isCorrect) {
            this.text = text;
            this.isCorrect = isCorrect;
        }

        getText() {
            return this.text;
        }

        getCorrect() {
            return this.isCorrect;
        }
    }

    function checkJSPData() {
        var answers = [];

        <%
        for (Question question: test.getQuestions()){
        for (Answer answer: question.getAnswers()){
        %>
        answers.push(new Answer('<%=answer.getText()%>', <%=answer.getCorrect()%>));
        <%
        }
        %>
        addNewQuestion('<%=question.getText()%>', '<%=question.getImgUrl()%>', answers);
        answers = [];
        <%
        }
        %>
    }

    function addNewQuestion(qText, qImg, answers) {
        var grid, cell, inputWrapper, input, inputLabel, title,
                answerList;

        var currC = counter;

        var inputQCounter = document.getElementById("input-question-counter");
        inputQCounter.setAttribute("value", String(counter));

        // Question main info
        grid = createGrid(PREFIX_ID_GRID + counter);
        cell = createCell(PREFIX_ID_CELL + "main-" + counter, 12);
        inputWrapper = createInputWrapper(PREFIX_ID_INPUT_WRAPPER + counter);
        input = createInput("text", PREFIX_ID_QUESTION_TEXT + counter, "<%=Parameter.PARAM_QUESTION_TEXT%>" + counter, qText);
        inputLabel = createInputLabel(input, "Текст питання");

        // Add main info
        grid.appendChild(cell);
        cell.appendChild(inputWrapper);
        inputWrapper.appendChild(input);
        inputWrapper.appendChild(inputLabel);

        // Question main info
        inputWrapper = createInputWrapper();
        input = createInput("url", PREFIX_ID_QUESTION_IMG_URL + counter, "<%=Parameter.PARAM_QUESTION_IMAGE_URL%>" + counter, qImg);
        inputLabel = createInputLabel(input, "Посилання на фото");

        // Add main info
        cell.appendChild(inputWrapper);
        inputWrapper.append(input);
        inputWrapper.append(inputLabel);

        // Question answers
        title = createTitle("Відповіді");
        title.style = "float: left";
        cell = createCell(PREFIX_ID_CELL + "questions-" + counter, 12);
        answerList = createList(PREFIX_ID_ANSWERS_LIST);
        grid.appendChild(cell);
        cell.appendChild(title);
        cell.appendChild(createButton("add", "blue-500", function () {
            createAnswer(
                    answerList,
                    currC,
                    PREFIX_ID_INPUT_ANSWERS_CHECKBOX + String("is-correct-" + answersCounter),
                    "<%=Parameter.PARAM_ANSWER_IS_CORRECT%>" + currC);
            componentHandler.upgradeDom();
        }));

        for (var i = 0; i < answers.length; i++) {
            createAnswer(
                    answerList,
                    currC,
                    PREFIX_ID_INPUT_ANSWERS_CHECKBOX + String("is-correct-" + answersCounter),
                    "<%=Parameter.PARAM_ANSWER_IS_CORRECT%>" + currC,
                    answers[i]);
        }

        // Answer list
        cell = createCell(PREFIX_ID_CELL + "answers-" + counter, 12);
        grid.appendChild(cell);
        cell.appendChild(answerList);

        componentHandler.upgradeDom();
        refreshCards();
        counter++;
    }

    function createGrid(id) {
        var previousGrid;

        if (counter == 1) {
            previousGrid = document.getElementById("title-questions");
        } else {
            previousGrid = document.querySelectorAll(".mdl-grid");
            previousGrid = previousGrid[previousGrid.length - 1];
        }

        var grid = document.createElement("div");

        grid.className = "mdl-grid mdl-shadow--8dp";
        grid.id = id;
        previousGrid.parentNode.insertBefore(grid, previousGrid.nextSibling);

        addHeader(grid);

        return grid;
    }

    function refreshCards() {
        var grid, title, cardCounter = 1;

        for (var i = 0; i <= counter; i++) {
            grid = document.getElementById(PREFIX_ID_GRID + i);

            if (grid != null) {
                title = document.getElementById(PREFIX_ID_TITLE_MAIN_INFO + i);
                title.innerHTML = "Питання №" + cardCounter;

                cardCounter++;
            }
        }
    }

    function createButton(icon, color, onClick) {
        var button = document.createElement("button");
        var buttonIcon = document.createElement("i");

        button.style = "float: right";
        button.className = "mdl-button mdl-js-button mdl-button--icon";

        buttonIcon.className = "material-icons mdl-color-text--" + color;
        buttonIcon.innerHTML = icon;
        button.type = "button";
        button.appendChild(buttonIcon);
        button.addEventListener("click", onClick);

        return button;
    }

    function addHeader(grid) {
        var cellTitle = createCell(PREFIX_ID_CELL + "questions-title-" + counter, 11);
        var cellButtonDelete = createCell(PREFIX_ID_CELL + "button-delete-" + counter, 1);
        var title = createTitle("Питання №" + counter);

        cellTitle.className = "question-title-cell";
        title.id = PREFIX_ID_TITLE_MAIN_INFO + counter;

        cellButtonDelete.className = "question-button-delete";

        cellButtonDelete.appendChild(createButton("delete", "red-500", function () {
            grid.parentNode.removeChild(grid);
            refreshCards();
            counter = counter - 1;
        }));
        cellTitle.appendChild(title);
        grid.appendChild(cellTitle);
        grid.appendChild(cellButtonDelete);
    }

    function createCell(id, width) {
        var cell = document.createElement("div");
        cell.id = id;

        cell.className = "mdl-cell mdl-cell--" + width + "-col";

        return cell;
    }

    function createInputWrapper(id) {
        var inputWrapper = document.createElement("div");
        inputWrapper.className = "mdl-textfield mdl-js-textfield";
        inputWrapper.id = id;

        return inputWrapper;
    }

    function createInput(type, id, inputName, inputValue) {
        var input = document.createElement("textarea");
        input.className = "mdl-textfield__input";
        input.setAttribute("name", inputName);
        input.setAttribute("type", type);
        input.setAttribute("rows", "2");
        input.id = id;

        if (inputValue != undefined)
            input.innerHTML = inputValue;

        return input;
    }

    function createInputLabel(input, text) {
        var inputLabel = document.createElement("label");
        inputLabel.className = "mdl-textfield__label";
        inputLabel.setAttribute("for", input.id);
        inputLabel.innerHTML = text;

        return inputLabel;
    }

    function createTitle(text) {
        var title = document.createElement("p");
        title.className = "mdl-typography--headline";
        title.innerHTML = text;

        return title;
    }

    function createList(id) {
        var ul = document.createElement("ul");
        ul.className = "list-icon mdl-list";

        return ul;
    }

    var radioFields = [];

    class RadioField {
        /*counter;
         radioButton;
         textField;*/

        constructor(counter, radioButton, textField) {
            this.counter = counter;
            this.radioButton = radioButton;
            this.textField = textField;
        }

        getCounter() {
            return this.counter;
        }

        getRadioButton() {
            return this.radioButton;
        }

        getTextField() {
            return this.textField;
        }
    }

    function createAnswer(list, questionCounter, radioButtonId, radioGroupName, answer) {
        if (radioFields[questionCounter] == undefined)
            radioFields[questionCounter] = [];

        var li = document.createElement("li");
        var label = document.createElement("label");
        var radioButton = document.createElement("input");
        var input = createInput("text", "", "<%=Parameter.PARAM_ANSWER_TEXT%>" + questionCounter, answer.getText());
        var inputLabel = createInputLabel(input, "Відповідь");
        var inputWrapper = createInputWrapper("");
        var span = document.createElement("span");

        inputWrapper.appendChild(input);
        inputWrapper.appendChild(inputLabel);
        inputWrapper.style = "margin-left: 16px";

        radioButton.type = "radio";
        radioButton.name = radioGroupName;
        radioButton.id = radioButtonId;
        radioButton.className = answer.getCorrect() ? "mdl-radio__button checked" : "mdl-radio__button";
        radioButton.checked = answer.getCorrect();

        label.className = "mdl-radio mdl-js-radio mdl-js-ripple-effect";
        label.htmlFor = radioButtonId;

        span.className = "mdl-checkbox__label";

        li.className = "mdl-list__item";

        label.appendChild(radioButton);
        label.appendChild(span);
        li.appendChild(label);
        li.appendChild(inputWrapper);
        list.appendChild(li);

        answersCounter++;

        radioFields[questionCounter].push(new RadioField(
                radioFields[questionCounter].length == 0 ?
                        1 : radioFields[questionCounter][radioFields[questionCounter].length - 1].getCounter() + 1,
                radioButton,
                input
        ));

        radioButton.setAttribute("value", radioFields[questionCounter].slice(-1)[0].getCounter());

        return li;
    }

    function deleteQuestion(questionGridId) {
        var questionGrid = document.getElementById(questionGridId);
        questionGrid.parentNode.removeChild(questionGrid);
    }
</script>

<form action="${pageContext.request.contextPath}/tests/edit" method="post" accept-charset="UTF-8">
    <input id="input-question-counter" type="hidden" name="<%=Parameter.PARAM_ANSWER_COUNT%>">
    <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>" value="<%=test.getId()%>">

    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
        <header class="mdl-layout__header">
            <div class="mdl-layout__header-row">
                <span class="mdl-layout-title">Новий тест</span>
                <div class="mdl-layout-spacer"></div>
                <nav class="mdl-navigation mdl-layout--large-screen-only">
                </nav>
            </div>
        </header>

        <%
            if (user.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
        %>
        <jsp:include page="/jsp/drawer_student.jsp"/>
        <%
        } else if (user.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
        %>
        <jsp:include page="/jsp/drawer_root.jsp"/>
        <%
            }
        %>

        <main class="mdl-layout__content">
            <div class="page-content" id="top">
                <p class="mdl-typography--display-1-color-contrast p-title">Основна інформація</p>

                <div class="mdl-grid mdl-shadow--8dp">
                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" name="<%=Parameter.PARAM_TEST_NAME%>" type="text"
                                   id="name" value="<%=test.getName()%>">
                            <label class="mdl-textfield__label" for="name">Назва</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <textarea class="mdl-textfield__input" type="text"
                                      name="<%=Parameter.PARAM_TEST_DESCRIPTION%>" rows="2"
                                      id="description"><%=test.getDescription()%></textarea>
                            <label class="mdl-textfield__label" for="description">Опис</label>
                        </div>
                    </div>

                    <div class="mdl-cell mdl-cell--12-col">
                        <div class="mdl-textfield mdl-js-textfield">
                            <input class="mdl-textfield__input" type="number" name="<%=Parameter.PARAM_TEST_TIME%>"
                                   id="time"
                                   value="<%=TimeFormatter.dateToMinutes(test.getTime())%>">
                            <label class="mdl-textfield__label" for="time">Час виконання (хв)</label>
                        </div>
                    </div>
                </div>

                <p id="title-questions" class="mdl-typography--display-1-color-contrast p-title">Питання</p>
            </div>
        </main>

        <div class="mdl-button--fab-menu" style="display: inline-block">
            <button id="fab-add-question"
                    style="display: block"
                    type="button"
                    class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored mdl-button--fab-menu-item"
                    onclick="addNewQuestion()">
                <i class="material-icons">add</i>
            </button>

            <button id="fab-done"
                    style="display: block"
                    class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored mdl-button--fab-menu-item"
                    type="submit">
                <i class="material-icons">done_all</i>
            </button>
        </div>

        <div class="mdl-tooltip mdl-tooltip--left" data-mdl-for="fab-add-question">
            Додати питання
        </div>

        <div class="mdl-tooltip mdl-tooltip--left" data-mdl-for="fab-done">
            Готово
        </div>
    </div>
</form>
</body>
</html>