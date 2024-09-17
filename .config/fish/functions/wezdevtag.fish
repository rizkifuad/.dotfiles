function wezdevtag -w "tag development window"
  set -l icon
  if test -f package.json
    set icon " "
    set -l react "$(grep 'react\|solid' package.json)"
    if test -n $react
      set icon ""
    end
  end

  if test -f go.mod
    set icon ""
  end

  if test -f pubspec.yaml
    set icon ""
  end

  wezterm cli set-tab-title "$icon $(basename (prompt_pwd))"
end
