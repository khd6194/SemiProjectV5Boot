<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--검색기능x 목록 조회-->
<c:set var="pglink" value="/board/list?cpg=" />
<!--검색기능o 목록 조회-->
<c:if test="${not empty param.fkey}">
    <c:set var="pglink" value="/board/find?ftype=${param.ftype}&fkey=${param.fkey}&cpg=" />
</c:if>
<div id="main">
    <div class="mt-5">
        <i class="fa-solid fa-pen-to-square fa-2xl"> 게시판 </i>
        <hr>
    </div>

    <div class="row mb-3">
        <div class="col-1">
            <select class="form-select" id="findtype">
                <option value="title">제목</option>
                <option value="titcont">제목+내용</option>
                <option value="content">내용</option>
                <option value="userid">작성자</option>
            </select></div>

        <div class="col-4 text-start">
            <input type="text" class="form-control col-2" id="findkey"
                   value="${param.fkey}"></div>

        <div class="col-3 text-start">
            <c:if test="${not empty sessionScope.UID}">
            <button type="button" id="findbtn" class="btn btn-light">
                <i class="fa-solid fa-magnifying-glass"></i>검색하기</button></div></c:if>
            <c:if test="${empty sessionScope.UID}">&nbsp;</c:if>
        <div class="offset-2 col-2 text-end">
            <c:if test="${not empty sessionScope.UID}">
            <button type="button" id="newbtn" class="btn btn-light">
                <i class="fa fa-plus-circle"></i>새글쓰기</button></c:if>
            <c:if test="${not empty sessionScope.UID}">
                &nbsp;</c:if>
        </div>

    </div>



    <div class="row">
        <div class="offset-1 col-10 text-center">
            <table class="table table-striped tbborder">
                <thead class="thbg">
                <tr>
                    <th style="width: 7%">번호</th><th>제목</th>
                    <th style="width: 12%">작성자</th><th style="width: 12%">작성일</th>
                    <th style="width: 7%">추천</th><th style="width: 7%">조회</th>
                </tr>
                </thead>
                <tr>
                    <th>공지</th>
                    <th><span class="badge badge-danger"></span>
                        석가탄신일,성탄절 대체공휴일 확정...27~29일 사흘 연휴</th>
                    <th>운영자</th><th>2023-05-04</th>
                    <th>567</th><th>1345</th>
                </tr>
                <c:forEach items="${bd}" var="bd">
                <tr>
                    <th>${bd.bno}</th>
                    <th><a href="/board/view?bno=${bd.bno}">${bd.title}</a></th>
                    <th>${bd.userid}</th><th>${fn:substring(bd.regdate,0,10)}</th>
                    <th>${bd.thumbs}</th><th>${bd.views}</th>
                </tr>
                </c:forEach>

            </table>
        </div>
    </div>


<%--    // 게시판 리스트 처리 - 페이징 --%>
<%--    // 1. 전체 게시물 수 처리 (bdcnt : 526) --%>
<%--    // 2. 페이지당 보여줄 게시물 수 지정 (=perPage : 10) --%>
<%--    // 3. 총 페이지 수 계산 (=> 52 + 1) --%>
<%--    // 4. 현재 페이지 번호 (cp, ) --%>
<%--    // ex) list.do?cp=1 : 526 ~ 517 --%>
<%--    // ex) list.do?cp=2 : 516 ~ 507 --%>
<%--    // ex) list.do?cp=3 : 506 ~ 497 --%>
<%--    // ... --%>
<%--    // ex) list.do?cp=n : x ~ x - 9 --%>
<%--    // x를 구하는 식 :(x-1) *10,(x-1) *10 --%>

    <%--
        // 게시판 리스트 처리 - 네비게이션
        // 현재 페이지에 따라서 보여줄 페이지 블럭을 결정
        // ex) cp = 1 : 1 2 3 4 5 6 7 8 9 10 다음
        // ex) cp = 3 : 1 2 3 4 5 6 7 8 9 10 다음
        // ex) cp = 9 : 1 2 3 4 5 6 7 8 9 10 다음
        // ex) cp = 11 : 이전 11 12 13 14 15 16 17 18 19 20 다음
        // ex) cp = 15 : 이전 11 12 13 14 15 16 17 18 19 20 다음
        // ex) cp = 23 : 이전 21 22 23 24 25 26 27 28 29 30 다음
        // ex) cp = 52: 이전 51 52 53 54 55
        // startPage = ((cp - 1) / 10) * 10 + 1
        // endPage = startPage + 10 - 1
    --%>

    <div class="row">
        <div class="offset-1 col-10 text-center">
            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${cpg gt 1}"><li class="page-item">
                        <a class="page-link" href="${pglink}1">처음</a></li>
                    </c:if>

                    <c:if test="${cpg - 1 gt 0}"><li class="page-item"></c:if>
                    <c:if test="${cpg - 1 le 0}"><li class="page-item disabled"></c:if>
                    <a class="page-link" href="${pglink}${cpg-1}">이전</a></li>

                    <c:forEach var="i" begin="${stpg}" end="${stpg + 10 - 1}">
                        <c:if test="${i le cntpg}">
                            <c:if test="${i ne cpg}"><li class="page-item"></c:if>
                            <c:if test="${i eq cpg}"><li class="page-item active"></c:if>
                            <a class="page-link" href="${pglink}${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${(cpg+1) lt cntpg}"><li class="page-item"></c:if>
                    <c:if test="${(cpg+1) gt cntpg}"><li class="page-item disabled"></c:if>
                    <a class="page-link" href="${pglink}${cpg+1}">다음</a></li>

                    <c:if test="${cpg lt cntpg}"><li class="page-item">
                        <a class="page-link" href="${pglink}${cntpg}">끝</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>



</div>

<script src="/assets/js/board.js"></script>

