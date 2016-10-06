local scenarios=table.new()
local teams=table.new{
  ssg={
    abbrev="SSG",
    region="KOR",
    name="Samsung Galaxy"
  },
  tsm={
    abbrev="TSM",
    region="NA",
    name="Team Solo Mid"
  },
  rng={
    apprev="RNG",
    region="CN",
    name="I May"
  },
  spy={
    abbrev="SPY",
    region="EU",
    name="Splyce"
  }
}
for ssgtsm=1,2 do
  for spyrng=1,2 do
    for tsmspy=1,2 do
      for ssgrng=1,2 do
        for spyssg=1,2 do
          for rngtsm=1,2 do
            group=require "group".new()
            local ssg=group:newteam(require "pl.tablex".deepcopy(teams.ssg))
            local tsm=group:newteam(require "pl.tablex".deepcopy(teams.tsm))
            local rng=group:newteam(require "pl.tablex".deepcopy(teams.rng))
            local spy=group:newteam(require "pl.tablex".deepcopy(teams.spy))
            group:game(ssg,spy,true)
            group:game(tsm,rng,false)
            group:game(tsm,ssg,true)
            group:game(rng,spy,true)
            group:game(spy,tsm,false)
            group:game(rng,ssg,false)
            group:game(ssg,tsm,ssgtsm==1)
            group:game(spy,rng,spyrng==1)
            group:game(tsm,spy,tsmspy==1)
            group:game(ssg,rng,ssgrng==1)
            group:game(spy,ssg,spyssg==1)
            group:game(rng,tsm,rngtsm==1)
            scenarios:insert(group)
          end
        end
      end
    end
  end
end
return {teams,scenarios}
