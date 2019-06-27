<article>
<table>
<tr>
    <td>{% if launcher.reachable %}
        {% if launcher.readytolaunch %}
        <button id="{{launcher.name}}_startstop" alt="Start this script" class="btn-large green" onclick="launch.call($(this),'{{launcher.name}}',this.value)" value="start"><i class="fa fa-play"></i></button>
        {% else %}
        <button alt="Some arguments are missing" class="btn-large amber" onclick="$('#{{launcher.name}}_args_btn').trigger('click')"><i class="fa fa-question"></i></button>
        {% endif %}
        {% else %}
        <span class="label label-warning"><i class="fa fa-question"></i></span>
        {% endif %}
    </td>
    <td><h5>{{ "%s" % launcher.prettyname}}</h5></td>
    <td>{% if launcher.has_args %}
        <button id="{{launcher.name}}_args_btn" class="btn light-blue" data-toggle="button" onclick="$('#{{launcher.name}}_args').toggle('fast');$(':first-child',this).toggleClass('fa-plus fa-minus')"><i {% if showargs %}class="fa fa-minus"{% else %}class="fa fa-plus"{% endif %}></i></button>
        {% endif %}
    </td>
    <td>
        {% if launcher.has_args %}
        <div id="{{launcher.name}}_args" {% if not showargs %}style="display:none"{% endif %} >
            {% for arg, values in launcher.args.items() %}
                <div class="row">
                    <div class="input-field">
                    <input id="{{arg}}_input" 
                    {% if values['doc'] %}
                        placeholder="{{ values['doc'] }}"
                    {% endif %}

                    {% if values['type'] == 'bool' %}
                           type='checkbox'
                           {{'checked' if values['value']}}
                           onchange="setarg.call($(this),'{{launcher.name}}','{{arg}}',this.checked)" />
                    {% else %}
                            {% if values['type'] in ['int', 'float'] %}
                              type='number' value="{{ values['value'] }}"
                            {% elif not values['value'] %}
                              style="background-color:#eb9316;"
                            {% else %}
                              type="text" value="{{ values['value'] }}" 
                            {% endif %}
                           onchange="setarg.call($(this),'{{launcher.name}}','{{arg}}',this.value)" />
                    {% endif %}
                    <label for="{{arg}}_input">{{ arg }}</label>
                    </div>
                </div>
            {% endfor %}
        </div>
        {% else %}{{launcher.desc}}</span>
        {% endif %}
    </td>
</tr>
</table>
</article>
