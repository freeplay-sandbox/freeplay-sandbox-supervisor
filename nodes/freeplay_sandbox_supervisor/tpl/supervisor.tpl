<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="The freeplay sandbox experiment supervisor for ROS">
    <meta name="author" content="Séverin Lemaignan">
    <link rel="icon" href="../../favicon.ico">

    <title>Freeplay Sandbox -- Supervisor</title>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Bootstrap theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- font awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

      <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Freeplay sandbox supervisor</a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">Status</a></li>
              <li><a href="#about">Recordings</a></li>
              <li><a href="#contact">Manage</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Not used yet<span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#">Action</a></li>
                  <li><a href="#">Another action</a></li>
                  <li><a href="#">Something else here</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </nav>

    <div class="page-header">
        <h1>Launchers</h1>
    </div>
    <table class="table table-striped">
    <thead>
        <tr>
        <th>Status</th>
        <th>Launch file</th>
        </tr>
    </thead>
    <tbody>
        {% for launcher in launchers %}
        <tr>
            <td>{% if launcher.reachable %}<a class="btn btn-sm btn-primary" href="#"  onclick="$('#{{launcher.name}}_args').toggle();"><i class="fa fa-chevron-circle-down"></i></a>

                {% else %}<span class="label label-warning"><i class="fa fa-question"></i></span>
                {% endif %}
            </td>
            <td><strong>{{ "%s" % launcher.prettyname}}</strong></td>
            <td>{% if launcher.reachable %}
                <div id="{{launcher.name}}_args" style="display:none">
                <table>
                <tr><td>
                    <table class="table table-condensed">
                    <tbody>
                        {% for arg, values in launcher.args.items() %}
                        <tr>
                            <td>{{ arg }} {% if values[0] %}<em>({{ values[0] }}) </em>{% endif %} <input class="form-control" value="{{ values[1] }}" /> </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                    </table>
</td><td>
                    <a class="btn btn-lg btn-success" href="#" onclick="launch('{{launcher.name}}',[1,2,3])"><i class="fa fa-play"></i></a>
                    </td></tr>
                    </table>
                </div>
                {% else %}{{launcher.desc}}</span>
                {% endif %}
            </td>
        </tr>
        {% endfor %}
    </tbody>
    </table>

    <div class="page-header">
        <h1>Nodes</h1>
    </div>
    <table class="table table-striped">
    <thead>
        <tr>
        <th>Status</th>
        <th>ROS node</th>
        <th>not used</th>
        <th>not used</th>
        </tr>
    </thead>
    <tbody>
        {% for node in nodes_ok %}
        <tr>
            <td><span class="label label-success">Ok</span></td>
            <td>{{ "%s" % node}}</td>
            <td></td>
            <td></td>
        </tr>
        {% endfor %}
        {% for node in nodes_ko %}
        <tr>
            <td><span class="label label-warning">Not responsive</span></td>
            <td>{{ "%s" % node}}</td>
            <td></td>
            <td></td>
        </tr>
        {% endfor %}
    </tbody>
    </table>

<script>
function launch(launchfile, args) {
    $.get('{{path}}?launch=' + launchfile + '&args=' + args, function(data) {
            console.log(data);
            });
}
</script>
</body>
</html>

