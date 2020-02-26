# function kubectl_status
#   set -l config $KUBECONFIG
#   [ -z "$config" ]; and set -l config "$HOME/.kube/config"
#   if [ ! -f $config ]
#     echo (set_color $fish_color_autosuggestion)"no config" (set_color -o red)"⎈"
#     return
#   end
#
#   set -l context (kubectl config current-context 2>/dev/null)
#   if [ $status -ne 0 ]
#     echo (set_color $fish_color_autosuggestion)"no context" (set_color -o red)"⎈"
#     return
#   end
#
#   set -l namespace (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")
#   [ -z $namespace ]; and set -l namespace 'default'
#
#   switch $context
#     case "*prod*"
#       set_color -o red
#     case "*stag*"
#       set_color -o yellow
#     case "*"
#       set_color $fish_color_autosuggestion
#   end
#   echo $context"|"$namespace (set_color -o cyan)"⎈"
# end
#
# function fish_right_prompt
#   kubectl_status
#   set_color normal
#   set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
#   echo " "
#   date "+%H:%M:%S"
#   set_color normal
# end
