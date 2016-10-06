--Auxillary functions to attatch to table
function table.new(tbl)
  tbl=tbl or {}
  setmetatable(tbl,{__index=table})
  return tbl
end
function table.contains(tbl,result)
  for i,v in pairs(tbl) do
    if v==result then
      return true
    end
  end
  return false
end
function table.containsrecursive(tbl,result)
  for i,v in pairs(tbl) do
    if v:contains(result) then
      return true
    end
  end
  return false
end
function table.containsprop(tbl,prop,value)
  for i,v in pairs(tbl) do
    if v[prop]==value then
      return true
    end
  end
  return false
end
