<!DOCTYPE html>
<html lang=en>
    <head>
        <meta charset="utf-8">
        <!--Import Google Icon Font-->
        <link href="css/material-icons.css" rel="stylesheet">
        <!--Import materialize.css-->
        <link rel="stylesheet" href="css/materialize.min.css">

        <!-- font awesome -->
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <!--<link
        href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">-->
 
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <meta name="description" content="A process manager for robotic experiments">
        <meta name="author" content="Séverin Lemaignan">
        <link rel="icon" href="../../favicon.ico">

        <title>Couch to 5k -- Supervisor</title>
    </head>

    <body>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
        <script src="js/materialize.min.js"></script>


        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper">
                    <ul class="right">
                        <li id="nav-status" class="active"><a onclick="switchTo('status')"><i class="material-icons left">search</i> Status</a></li>
                        <li id="nav-manage"><a onclick="switchTo('manage')"><i class="material-icons left">mode_edit</i> Manage</a></li>
                        <li><a onclick="document.documentElement.mozRequestFullScreen();"><i class="fa fa-arrows-alt"></i></a></li>
                    </ul>
                </div>
            </nav>
        </div>

        <div id="status-tab" style="display:none;">
        {% include 'status.tpl' %}
        </div>
        <div id="manage-tab" style="display:none;">
        {% include 'manage.tpl' %}
       </div>

        <script>
        function switchTo(tab) {


            if(tab === "status") {
                $("#nav-status").addClass("active")
                $("#status-tab").css("display", "block")
            } 
            else {
                $("#nav-status").removeClass("active")
                $("#status-tab").css("display", "none")
            };

            if(tab === "manage") {
                $("#nav-manage").addClass("active")
                $("#manage-tab").css("display", "block")
            } 
            else {
                $("#nav-manage").removeClass("active")
                $("#manage-tab").css("display", "none")
            };
        }
        </script>
</body>
</html>

