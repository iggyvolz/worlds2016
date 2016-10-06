local scenarios=table.new()
local teams=table.new{
  skt={
    abbrev="SKT",
    region="KOR",
    name="SK Telecom T1"
  },
  c9={
    abbrev="C9",
    region="NA",
    name="Cloud9"
  },
  im={
    apprev="im",
    region="CN",
    name="I May"
  },
  fw={
    abbrev="FW",
    region="CN", -- ???
    name="Flash Wolves"
  }
}
for imfw=1,2 do
  for c9skt=1,2 do
    for c9fw=1,2 do
      for sktim=1,2 do
        for imc9=1,2 do
          for fwskt=1,2 do
            group=require "group".new()
            local skt=group:newteam(require "pl.tablex".deepcopy(teams.skt))
            local c9=group:newteam(require "pl.tablex".deepcopy(teams.c9))
            local im=group:newteam(require "pl.tablex".deepcopy(teams.im))
            local fw=group:newteam(require "pl.tablex".deepcopy(teams.fw))
            group:game(skt,c9,true)
            group:game(fw,im,false)
            group:game(fw,c9,false)
            group:game(im,skt,false)
            group:game(skt,fw,false)
            group:game(c9,im,true)
            group:game(im,fw,imfw==1)
            group:game(c9,skt,c9skt==1)
            group:game(c9,fw,c9fw==1)
            group:game(skt,im,sktim==1)
            group:game(im,c9,imc9==1)
            group:game(fw,skt,fwskt==1)
            scenarios:insert(group)
          end
        end
      end
    end
  end
end
return {teams,scenarios}
