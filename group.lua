region={
  abbrev=nil,
  name=nil
}
team={
  abbrev=nil,
  region=nil,
  name=nil,
  wins=0,
  losses=0
}
game={
  team1=nil,
  team2=nil,
  winner=nil -- true: team1 wins, false: team1 wins
}
group={
  games=table.new(),
  teams=table.new()
}
result={
  first=nil,
  second=nil,
  third=nil,
  fourth=nil
}
function group.game(grp,team1,team2,team1wins)
  grp.games:insert{team1=team1,team2=team2,winner=team1wins}
  local winner=(team1wins and team1 or team2)
  local loser=(team1wins and team2 or team1)
  winner.wins=winner.wins+1
  loser.losses=loser.losses+1
end
function group.new()
  grp={}
  setmetatable(grp,{__index=group})
  grp.games=table.new()
  grp.teams=table.new()
  return grp
end
function group.newteam(grp,tm)
  tm=tm or {}
  setmetatable(tm,{__index=team})
  grp.teams:insert(tm)
  return tm
end
function group.results(grp)
  local result=table.new()
  local skips=0
  for i=1,#grp.teams do -- Get 1 through 4
    if skips == 0  then
      local wins=0
      local winningteams=table.new()
      for j=1,#grp.teams do -- Sort through all teams
        if not result:containsrecursive(grp.teams[j]) then -- If team is not already accounted for, then go on
          if grp.teams[j].wins>wins then -- We have more wins than the current highest team
            wins=grp.teams[j].wins
            winningteams=table.new{grp.teams[j]}
          elseif grp.teams[j].wins==wins then -- TIE
            winningteams:insert(grp.teams[j])
          end
        end
      end
      result[i]=winningteams
      if #winningteams>1 then
        -- Dirty hack to advance i
        skips=#winningteams-1
      end
    else
      skips=skips-1
    end
  end
  return result
end
function group.resultspretty(grp)
  --local results=grp:results()
  ret="GROUP RESULTS\n"
  for i,v in pairs(grp.teams) do
    ret=ret..v.name..": "..v.wins.."-"..v.losses.."\n"
  end
  return ret.."\n\n"
end
return group
