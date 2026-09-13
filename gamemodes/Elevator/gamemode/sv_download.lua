local ContentPrefix = "../addons/"
local LoadedList = {}
local ValidExtensions = {"vmt", "mdl", "wav","mp3"}


local function AddResourceDirectory(ContentPrefix,Directory)

	for _,v in pairs(file.Find(ContentPrefix..Directory.."/*")) do

		local File = Directory.."/"..v

		if v != "_svn" && v != ".svn" then

			if file.IsDir(ContentPrefix..File) then
			
				AddResourceDirectory(ContentPrefix, File)
				
			else
				
				local ext = string.GetExtensionFromFilename(v)
				
				if table.HasValue(ValidExtensions, ext) then
					local DownloadFile = string.lower(  string.sub( File, 2 ) )				
					resource.AddFile( DownloadFile )
					
					if ( ext == "mp3" || ext == "wav" ) then
						util.PrecacheSound( DownloadFile )
					end
					
					if ( ext == "mdl" ) then
						util.PrecacheModel( DownloadFile )
					end
				end
				
			end

		end

	end

end

function RequireAddon( name )

	if table.HasValue( LoadedList, name ) then
		return
	end
	
	AddResourceDirectory( "../addons/" .. name, "" )

end

RequireAddon( "elevator" )