local scenarios=table.new()
local teams=table.new{
  edg={
    abbrev="EDG",
    region="CN",
    name="Edward Gaming"
  },
  ahq={
    abbrev="AHQ",
    region="CN",
    name="AHQ eSports Club"
  },
  h2k={
    apprev="H2K",
    region="EU",
    name="H2K Gaming"
  },
  itz={
    abbrev="ITZ",
    region="BRA",
    name="INTZ eSports Club"
  }
}
for edgitz=1,2 do
  for ahqh2k=1,2 do
    for h2kedg=1,2 do
      for itzahq=1,2 do
        for itzh2k=1,2 do
          for ahqedg=1,2 do
            group=require "group".new()
            local edg=group:newteam(require "pl.tablex".deepcopy(teams.edg))
            local ahq=group:newteam(require "pl.tablex".deepcopy(teams.ahq))
            local h2k=group:newteam(require "pl.tablex".deepcopy(teams.h2k))
            local itz=group:newteam(require "pl.tablex".deepcopy(teams.itz))
            group:game(h2k,ahq,false)
            group:game(itz,edg,true)
            group:game(h2k,itz,true)
            group:game(edg,ahq,true)
            group:game(ahq,itz,true)
            group:game(edg,h2k,true)
            group:game(edg,itz,edgitz==1)
            group:game(ahq,h2k,ahqh2k==1)
            group:game(h2k,edg,h2kedg==1)
            group:game(itz,ahq,itzahq==1)
            group:game(itz,h2k,itzh2k==1)
            group:game(ahq,edg,ahqedg==1)
            scenarios:insert(group)
          end
        end
      end
    end
  end
end
return {teams,scenarios}
