function export
    if [ $argv ] 
        # set var (echo $argv | cut -f1 -d=)
        # set val (echo $argv | cut -f2 -d=)
        set splitted (string split = $argv -m 1)
        set -g -x $splitted[1] $splitted[2]
    else
        echo 'export var=value'
    end
end
