dofile("table.lua")
function round(num, idp)
  return string.format("%." .. (idp or 0) .. "f", num)
end
function perc(wins,possible)
  return round(wins*100/possible,2).."%"
end
for h=97,100 do
  print("Group "..string.char(h):upper()..":")
  local teams,scenarios=table.unpack(require ("group"..string.char(h)))
  for i,team in pairs(teams) do
    local firsts=0
    local t2firsts=0
    local t3firsts=0
    local t4firsts=0
    local seconds=0
    local t2seconds=0
    local t3seconds=0
    local thirds=0
    local t2thirds=0
    local fourths=0
    for j=1,#scenarios do
      local results=scenarios[j]:results()
      --require "pl.pretty".dump(results)
      if results[1] and results[1]:containsprop("name",team.name) then
        if #results[1] == 1 then
          firsts=firsts+1
        elseif #results[1] == 2 then
          t2firsts=t2firsts+1
        elseif #results[1] == 3 then
          t3firsts=t3firsts+1
        elseif #results[1] == 4 then
          t4firsts=t4firsts+1
        else
          error("WTF")
        end
      end
      if results[2] and results[2]:containsprop("name",team.name) then
        if #results[2] == 1 then
          seconds=seconds+1
        elseif #results[2] == 2 then
          t2seconds=t2seconds+1
        elseif #results[2] == 3 then
          t3seconds=t3seconds+1
        else
          error("WTF")
        end
      end
      if results[3] and results[3]:containsprop("name",team.name) then
        if #results[3] == 1 then
          thirds=thirds+1
        elseif #results[3] == 2 then
          t2thirds=t2thirds+1
        else
          error("WTF")
        end
      end
      if results[4] and results[4]:containsprop("name",team.name) then
        if #results[4] == 1 then
          fourths=fourths+1
        else
          error("WTF")
        end
      end
    end
    print("",team.name..":")
    print("","","First place:")
    print("","","","Outright:",perc(firsts,#scenarios))
    print("","","","Two-way tie:",perc(t2firsts,#scenarios))
    print("","","","Three-way tie:",perc(t3firsts,#scenarios))
    print("","","","Four-way tie:",perc(t4firsts,#scenarios))
    -- Firsts overall are firsts + half of two-way firsts + 1/3 of three-way firsts + 1/4 of four-way firsts
    print("","","","Overall:",perc((firsts+(t2firsts/2)+(t3firsts/3)+(t4firsts/4)),#scenarios))
    print("","","Second place:")
    print("","","","Outright:",perc(seconds,#scenarios))
    print("","","","Two-way tie:",perc(t2seconds,#scenarios))
    print("","","","Three-way tie:",perc(t3seconds,#scenarios))
    -- Seconds overall are seconds + half of two-way firsts + 1/3 of three-way firsts + 1/4 of four-way firsts + half of two-way seconds + 1/3 of three-way seconds
    print("","","","Overall:",perc((seconds+(t2firsts/2)+(t3firsts/3)+(t4firsts/4)+(t2seconds/2)+(t3seconds/2)),#scenarios))
    -- Advancing is taking first or second
    print("","","","Advance:",perc((seconds+(t2firsts/2)+(t3firsts/3)+(t4firsts/4)+(t2seconds/2)+(t3seconds/2)+firsts+(t2firsts/2)+(t3firsts/3)+(t4firsts/4)),#scenarios))
    print("","","Third place:")
    print("","","","Outright:",perc(thirds,#scenarios))
    print("","","","Two-way tie:",perc(t2thirds,#scenarios))
    -- Thirds ovrall are thirds + 1/3 of three-way firsts + 1/4 of four-way firsts + 1/2 of two-way seconds + 1/3 of three-way seconds + 1/2 of two-way thirds
    print("","","","Overall:",perc(thirds+(t3firsts/3)+(t4firsts/4)+(t2seconds/2)+(t3seconds/3)+(t2thirds/2),#scenarios))
    print("","","Fourth place:")
    print("","","","Outright:",perc(fourths,#scenarios))
    -- Fourths overall are fourths + 1/4 of four-way firsts + 1/3 of three-way seconds + 1/2 of two-way thirds
    print("","","","Overall:",perc(fourths+(t4firsts/4)+(t3seconds/3)+(t2thirds/2),#scenarios))
  end
end
