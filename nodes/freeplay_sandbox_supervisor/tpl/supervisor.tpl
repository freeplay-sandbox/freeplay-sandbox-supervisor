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

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <meta name="description" content="The freeplay sandbox experiment supervisor for ROS">
        <meta name="author" content="Séverin Lemaignan">
        <link rel="icon" href="../../favicon.ico">

        <title>Freeplay Sandbox -- Supervisor</title>
    </head>

    <body>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
        <script src="js/materialize.min.js"></script>


        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper">
                    <ul class="right">
                        <li class="{{ 'active' if page == 'records' }}"><a href="/"><i class="material-icons left">assignment_ind</i> Records</a></li>
                        <li class="{{ 'active' if page == 'status' }}"><a href="/status"><i class="material-icons left">search</i> Status</a></li>
                        <li class="{{ 'active' if page == 'manage' }}"><a href="/manage"><i class="material-icons left">mode_edit</i> Manage</a></li>
                        <li><a onclick="document.documentElement.mozRequestFullScreen();"><i class="fa fa-arrows-alt"></i></a></li>
                    </ul>
                </div>
            </nav>
        </div>

    {% if page == "records" %}
        {% include 'records.tpl' %}
    {% elif page == "status" %}
        {% include 'status.tpl' %}
    {% elif page == "manage" %}
        {% include 'manage.tpl' %}
    {% endif %}

</body>
</html>

