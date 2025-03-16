Config = {}

Config.CraftPeds = {
    ['test'] = {
        model = "s_m_y_construct_01",
        coords =  vector4(-1189.86, -877.31, 13.66, 38.10),
        label = 'Meet with Michael',
        items = {
            ["weapon_pistol"] = {
                label = "Pistol",
                time = 1000,
                requiredItems = {
                    { item = "steel", amount = 5 },
                    { item = "plastic", amount = 3 }
                }
            },
            ["weapon_assaultrifle"] = {
                label = "AK-47",
                time = 8000,
                requiredItems = {
                    { item = "steel", amount = 15 },
                    { item = "plastic", amount = 8 }
                }
            }
        }
    }
}



Config.Locale = "en" -- tr or en

Config.Locales = {
    ["en"] = {
        menu_header = "Crafting",
        crafting_in_progress = "Crafting in Progress...",
        craft_complete = "Craft Complete!",
        not_enough_materials = "Not Enough Materials!",
        select_craft_amount = "Select Craft Amount",
        enter_craft_amount = "How many do you want to craft?",
        invalid_amount = "Invalid amount!",
        required_items = "Required items:"
    },
    ["tr"] = {
        menu_header = "Crafting",
        crafting_in_progress = "Craft Yapılıyor...",
        craft_complete = "Craft tamamlandı!",
        not_enough_materials = "Yeterli malzeme yok!",
        select_craft_amount = "Craft Miktarı Seç",
        enter_craft_amount = "Kaç adet craftlamak istiyorsun?",
        invalid_amount = "Geçerli bir miktar gir!",
        required_items = "Gerekli eşyalar:"
    }
}


function Locales(key)
    local lang = Config.Locale
    return Config.Locales[lang][key] or key
end
