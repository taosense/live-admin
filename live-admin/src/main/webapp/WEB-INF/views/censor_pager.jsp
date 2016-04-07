<%@ page language="java" pageEncoding="utf-8"%>
<div class="row">
                        <div class="col-xs-6">
                            <div class="dataTables_info" id="dynamic-table_length">
                                <label>显示 <select name="dynamic-table_length"
                                    value="${pager.pageSize}" id="page-size"
                                    aria-controls="dynamic-table" class="form-control input-sm"><option
                                            value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option></select> 条
                                </label> <label> 第<c:choose>
                                        <c:when test="${ pager.recordCount==0}">0</c:when>
                                        <c:otherwise>${pager.skip+1}</c:otherwise>
                                    </c:choose>- <c:out value="${pager.skip+fn:length(pager.results)}"></c:out>
                                    条，共${pager.recordCount}条记录
                                </label>
                            </div>
                        </div>


                        <div class="col-xs-6">
                            <div class="dataTables_paginate paging_simple_numbers"
                                id="pagination"></div>
                        </div>
                    </div>