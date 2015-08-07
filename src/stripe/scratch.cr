#module S
#  {% for xx in foo %}
#    # this is matching as "before @" not "before ;"
#    p x
#  {% end %}
#  {% if "hello%}" %}
#
#               p x
#{% end %}

# down here we're falling through to no indent -- nothing matches?
#def x
#end
#end
