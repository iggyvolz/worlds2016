local scenarios=table.new()
local teams=table.new{
  clg={
    abbrev="CLG",
    region="NA",
    name="Counter Logic Gaming"
  },
  anx={
    abbrev="ANX",
    region="CIS",
    name="Albus Nox Luna"
  },
  g2={
    apprev="G2",
    region="EU",
    name="Gamers2"
  },
  rox={
    abbrev="ROX",
    region="KOR",
    name="ROX Tigers"
  }
}
for g2rox=2,2 do
  for anxclg=2,2 do
    for clgg2=1,2 do
      for anxrox=1,2 do
        for g2anx=1,2 do
          for roxclg=1,2 do
            group=require "group".new()
            local clg=group:newteam(require "pl.tablex".deepcopy(teams.clg))
            local anx=group:newteam(require "pl.tablex".deepcopy(teams.anx))
            local g2=group:newteam(require "pl.tablex".deepcopy(teams.g2))
            local rox=group:newteam(require "pl.tablex".deepcopy(teams.rox))
            group:game(g2,clg,false)
            group:game(rox,anx,true)
            group:game(clg,anx,false)
            group:game(rox,g2,true)
            group:game(anx,g2,true)
            group:game(clg,rox,true)
            group:game(g2,rox,g2rox==1)
            group:game(anx,clg,anxclg==1)
            group:game(clg,g2,clgg2==1)
            group:game(anx,rox,anxrox==1)
            group:game(g2,anx,g2anx==1)
            group:game(rox,clg,roxclg==1)
            --print(group:resultspretty())
            scenarios:insert(group)
          end
        end
      end
    end
  end
end
return {teams,scenarios}
