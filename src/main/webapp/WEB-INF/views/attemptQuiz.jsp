<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cdgi.pojo.Question"%>

<%@include file="header.jsp"%>

<div class="container mt-5">

    <h2 class="text-center mb-3">Quiz Started</h2>

    <!-- ✅ TIMER -->
    <div class="text-center mb-4">
        <div class="d-inline-block px-4 py-2 rounded" style="background:#f8f9fa; border:2px solid #dee2e6;">
            <h5 class="mb-0">⏱ Time Remaining: 
                <span id="timer" style="color:#dc3545; font-weight:bold; font-size:24px;"></span>
            </h5>
        </div>
    </div>

    <form action="submitQuiz" method="post" id="quizForm">

        <input type="hidden" name="quizId" value="<%=request.getAttribute("quizId")%>">

        <%
        @SuppressWarnings("unchecked")
        List<Question> qlist = (List<Question>) request.getAttribute("questions");
        for(int i = 0; i < qlist.size(); i++) {
            Question q = qlist.get(i);
        %>

        <div class="card mt-3 p-3">
            <p><b>Q<%=i+1%>. <%=q.getQuestion()%></b></p>

            <input type="radio" name="q<%=q.getId()%>" value="A"> <%=q.getOptionA()%><br>
            <input type="radio" name="q<%=q.getId()%>" value="B"> <%=q.getOptionB()%><br>
            <input type="radio" name="q<%=q.getId()%>" value="C"> <%=q.getOptionC()%><br>
            <input type="radio" name="q<%=q.getId()%>" value="D"> <%=q.getOptionD()%><br>
        </div>

        <%
        }
        %>

        <div class="text-center mt-4 mb-5">
            <button type="submit" class="btn btn-success btn-lg">Submit Quiz</button>
        </div>

    </form>

</div>

<%@include file="footer.jsp"%>

<!-- ✅ TIMER SCRIPT -->
<script>
    var duration = <%= request.getAttribute("duration") %> * 60; // minutes to seconds

    var timerDisplay = document.getElementById("timer");

    function updateTimer() {
        var minutes = Math.floor(duration / 60);
        var seconds = duration % 60;

        timerDisplay.textContent =
            (minutes < 10 ? "0" : "") + minutes + ":" +
            (seconds < 10 ? "0" : "") + seconds;

        // Last 1 minute - red warning
        if (duration <= 60) {
            timerDisplay.style.color = "#dc3545";
            timerDisplay.style.animation = "blink 1s step-start infinite";
        }

        // Time up - auto submit
        if (duration <= 0) {
            clearInterval(interval);
            alert("⏰ Time Up! Quiz is being submitted automatically...");
            document.getElementById("quizForm").submit();
            return;
        }

        duration--;
    }

    // Start timer
    updateTimer();
    var interval = setInterval(updateTimer, 1000);

    // Blinking animation for last minute
    var style = document.createElement('style');
    style.innerHTML = '@keyframes blink { 50% { opacity: 0; } }';
    document.head.appendChild(style);
</script>
