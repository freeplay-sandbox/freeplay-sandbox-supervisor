<p>

<button id="items_to_stash" alt="Items to stash" class="btn btn-lg btn-primary btn-block" onclick="perform('itemstostash')"><i class="fa fa-sign-in"></i>Interactive items to stash</button>
<button id="reshuffle_items" alt="Reshuffle items" class="btn btn-lg btn-primary btn-block" onclick="perform('reshuffleitems')"><i class="fa fa-random"></i>Reshuffle interactive items</button>
<button id="clearing_bg" alt="Clearing background" class="btn btn-lg btn-primary btn-block" onclick="perform('clearbackground')"><i class="fa fa-eraser"></i>Clear any drawings</button>


</p>

<script>

function perform(action) {
    $.ajax({
        url:'{{path}}?action=' + action,
        dataType: "json",
        context: this,
        success: function(isrunning) {
                    $(this).toggleClass('btn-primary', 'btn-secondary');
                }

        });
}

</script>

