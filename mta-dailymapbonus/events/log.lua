local logfolder = 'logs/'
local dump = {}

local function logget(filename)
  assert( type(filename) == 'string',
    'ERROR: bad log file name' .. tostring(filename)
  )

  local dumpfile = dump[filename]
  if dumpfile then
    return dumpfile
  end

  local dumpfile = nil
  collectgarbage('collect')

  local pathstring = logfolder .. filename .. '.log'
  local file = (not fileExists(pathstring)
    and fileCreate(pathstring)
    or fileOpen(pathstring)
    or outputDebugString(
      string.format('ERROR: failed to load log file: %s',
        pathstring
      )
    )
  )
  if not file then
    return false
  end

  file.pos = file.size
  dump[filename] = file
  return file
end

function log(filename, message)
  local file = logget(filename) or false
  return (file
    and ( fileWrite( file,
        (file.size > 0 and '\n' or '') .. os.date'[%Y-%m-%d %H:%M:%S] ' .. message
      )
      and fileFlush(file)
    )
    or ( outputDebugString('ERROR: file not found')
      and false
    )
  )
end