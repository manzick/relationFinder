--
-- For more information on config.lua see the Corona SDK Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 720,
		height = 1280, 
		scale = "letterBox",
		fps = 60,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},
	license =
    {
        google =
        {
            key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnAA5x6m9cuHTbN2CP2aW/b5q46KbDsVJmZOWryvTg3AnirWMtWdEgOFSZMm48kPm9+vizEeqNvPJNNrzkW5og6BOjw1kMOH0YiW2O535AoSMzLbdUmRLTLnENvVb4MQmu2EQK8GtLrjPQJ4Zf9I+Dea66su5Fld4O+tDq0j/KVDH5Rp+GF46dY5hULbE0FnutjI8Od6601RaYOfMdDqSQSQovRzKzbjjvSiY1BWHF3d+hZet+YNAoMcAOUGjLN9p7+WSmXYmEi1nqR8VR/FzvQngOr9ulj4ohahyE45//cRcWVRtyLqe4oGoiC1Jkf7v289dNd1LRqq3fyT0Lc6TmQIDAQAB",
        },
    },
}
