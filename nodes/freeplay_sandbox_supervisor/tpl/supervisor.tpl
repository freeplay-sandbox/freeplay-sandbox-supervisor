<!DOCTYPE html>
<html lang=en>
    <head>
        <meta charset="utf-8">
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/css/materialize.min.css">

        <!-- font awesome -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <meta name="description" content="The freeplay sandbox experiment supervisor for ROS">
        <meta name="author" content="Séverin Lemaignan">
        <link rel="icon" href="../../favicon.ico">

        <title>Freeplay Sandbox -- Supervisor</title>
    </head>

    <body>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>


        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper">
                    <a href="#!" class="brand-logo">Freeplay Sandbox</a>
                    <ul class="right hide-on-med-and-down">
                        <li class="{{ 'active' if page == 'records' }}"><a href="/">Records</a></li>
                        <li class="{{ 'active' if page == 'status' }}"><a href="/status">Status</a></li>
                        <li class="{{ 'active' if page == 'manage' }}"><a href="/manage">Manage</a></li>
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

