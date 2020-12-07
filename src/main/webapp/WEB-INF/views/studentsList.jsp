<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理系统</title>
    <script type="text/javascript" src="../../static/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../../static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
    <link href="../../static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <!--1、放置标题  -->
    <div class="row">
        <div class="page-header">
            <h1>学生列表</h1>
        </div>
    </div>

    <!--2、放置全局性按钮或输入框  -->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-info" id="stu_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>

    <div class="row" style="height: 10px"></div>

    <!--3、放置学生列表table  -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped" id="stus_table">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>学号</th>
                    <th>系部</th>
                    <th>班级</th>
                    <th>姓名</th>
                    <th>早温</th>
                    <th>午温</th>
                    <th>晚温</th>
                    <th>操作</th>
                </tr>


                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>

    <!--4、放置分页条  -->
    <div class="row">
        <div class="col-md-6" id="page_info_div"></div>
        <!--内部的html元素都采用js来动态的生成  -->
        <div class="col-md-6" id="page_nav_div"></div>
    </div>

    <script type="text/javascript">
        //1、页面加载完成但还未显示时后，发送ajax请求，查到分页数据
        $(function() {
            to_page(1);
        });


        function to_page(pageNum){
            $.ajax({
                url:"studentsList",//发送的请求名称
                data:"pageNum="+pageNum,//发送的参数是页码
                type:"get",//以get方式发送
                success:function(result){
                    console.log(result);
                    //1.解析并显示员工数据
                    build_stus_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析并显示分页条
                    build_page_nav(result);
                }
            });
        }

        function build_stus_table(result){
            $("#stus_table tbody").empty();
            //最好使用console.log打印result,输出观察一下result内部结构，或者使用浏览器的调试工具
            var stus = result.datas.stuPageInfo.list;
            $.each(stus, function(index, item){
                //一下这种形式是jquery创建html元素的语法，如果不理解，看一下jquery语法
                var seq = $("<td></td>").append(index+1);
                var stuId = $("<td></td>").append(item.id);
                var stuDeptName = $("<td></td>").append(item.department);
                var className = $("<td></td>").append(item.className);
                var stuName = $("<td></td>").append(item.name);
                var tempreture1 = $("<td></td>").append(item.tempretrue1);
                var tempreture2 = $("<td></td>").append(item.tempretrue2);
                var tempreture3 = $("<td></td>").append(item.tempretrue3);


                var editBtn = $("<Button></Button>").addClass("btn btn-primary btn-xs").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                var deltBtn = $("<Button></Button>").addClass("btn btn-danger btn-xs").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deltBtn);

                $("<tr></tr>").append(seq).append(stuId).append(stuDeptName).append(className).append(stuName).
                append(tempreture1).append(tempreture2).append(tempreture3).
                append(btnTd).appendTo("#stus_table tbody");
            });
        }

        function build_page_info(result){
            $("#page_info_div").empty();
            $("#page_info_div").append("当前第" + result.datas.stuPageInfo.pageNum + "页，总共"
                + result.datas.stuPageInfo.pages + "页，共有"
                + result.datas.stuPageInfo.total + "条数据");
        }

        function build_page_nav(result){
            $("#page_nav_div").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

            if(result.datas.stuPageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                firstPageLi.click(function(){
                    to_page(1);
                });

                prePageLi.click(function(){
                    to_page(result.datas.stuPageInfo.pageNum - 1);
                });
            }


            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            if(result.datas.stuPageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                lastPageLi.click(function(){
                    to_page(result.datas.stuPageInfo.pages);
                });
                nextPageLi.click(function(){
                    to_page(result.datas.stuPageInfo.pageNum + 1);
                });
            }


            ul.append(firstPageLi).append(prePageLi);

            $.each(result.datas.stuPageInfo.navigatepageNums, function(index, item){
                var pageNumLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.datas.stuPageInfo.pageNum == item){
                    pageNumLi.addClass("active");
                }
                pageNumLi.click(function(){
                    to_page(item);
                });
                ul.append(pageNumLi);
            });

            ul.append(nextPageLi).append(lastPageLi);

            var nav = $("<nav></nav>").append(ul);
            nav.appendTo("#page_nav_div")

        }
    </script>

    <script type="text/javascript">
        $("#stu_add_modal_btn").click(function(){
            //点击新增按钮提弹出新增界面
            $("#stuAddModal").modal({
                backdrop:"static"

            });
        });
    </script>

    <!-- Modal -->
    <div class="modal fade" id="stuAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog"  style="pointer-events:auto">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">增加学生</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">系部</label>
                            <div class="col-sm-10">
                                <input type="text" name="department" class="form-control" id="input_department" placeholder="请输入系部名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">班级</label>
                            <div class="col-sm-6">
                                <input type="text" name="className" class="form-control" id="input_className" placeholder="请输入班级名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="name" id="input_name" placeholder="请输入姓名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">早温</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="tempretrue1" id="input_tempretrue1" placeholder="请输入早温">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">午温</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="tempretrue2" id="input_tempretrue2" placeholder="请输入午温">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">晚温</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" name="tempretrue3" id="input_tempretrue3" placeholder="请输入午温">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="save_stu_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#save_stu_btn").click(function(){
            //alert("Hello");

            //发送ajax请求
            $.ajax({
                url:"studentsList",
                type:"POSt",
                data:$("#stuAddModal form").serialize(),
                success:function(result){
                    alert(result.msg);
                    $("#stuAddModal").modal('hide');
                    to_page(9999);
                }
            });
        });
    </script>
</div>
</body>
</html>