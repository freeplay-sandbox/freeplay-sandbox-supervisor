<tr>
    <td>{% if launcher.reachable %}
        {% if launcher.readytolaunch %}
        <button alt="Start this launch file" class="btn btn-sm btn-success" onclick="launch('{{launcher.name}}',[1,2,3])"><i class="fa fa-play"></i></button>
        {% else %}
        <button alt="Some arguments are missing" class="btn btn-sm btn-warning"><i class="fa fa-question"></i></button>
        {% endif %}
        {% else %}
        <span class="label label-warning"><i class="fa fa-question"></i></span>
        {% endif %}
    </td>
    <td><strong>{{ "%s" % launcher.prettyname}}</strong></td>
    <td>{% if launcher.has_args %}
        <button class="btn btn-sm btn-info" data-toggle="button" onclick="$('#{{launcher.name}}_args').toggle();$(':first-child',this).toggleClass('fa-plus fa-minus')"><i {% if showargs %}class="fa fa-minus"{% else %}class="fa fa-plus"{% endif %}></i></button>
        {% endif %}
    </td>
    <td>
        {% if launcher.has_args %}
        <ul id="{{launcher.name}}_args" {% if not showargs %}style="display:none"{% endif %} class="list-group">
            {% for arg, values in launcher.args.items() %}
                <li class="list-group-item">
                    {{ arg }}
                    {% if values[0] %}
                    <em>({{ values[0] }}) </em>
                    {% endif %}
                    <input class="form-control"
                           {% if not values[1] %}style="background-color:#eb9316;"
                           {% else %}
                           value="{{ values[1] }}" 
                           {% endif %}
                           onchange="setarg.call($(this),'{{launcher.name}}','{{arg}}',this.value)" />
                </li>
            {% endfor %}
        </ul>
        {% else %}{{launcher.desc}}</span>
        {% endif %}
    </td>
</tr>

