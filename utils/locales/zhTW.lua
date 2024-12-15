---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "zhTW" then return end

---@class Locale
local L = MapPinEnhanced.L
L["Set \"%s\" Loaded"] = "標記集合 \"%s\" 已讀取"
L["Accept"] = "接受"
L["Add Pin"] = "新增標記"
L["Add to a Set"] = "新增到集合"
L["Are you sure you want to delete this set?"] = "你確定你要刪除此集合?"
L["Auto Track Nearest Pin"] = "自動追蹤最近的標記"
L["Automatic Visibility"] = "自動顯示"
L["Automatic"] = "自動"
L["Back"] = "Back"
L["Background Opacity"] = "背景透明度"
L["Can't Show on Map in Combat"] = "戰鬥中無法顯示在地圖上"
L["Cancel"] = "取消"
L["Change Color"] = "變更顏色"
L["Clear All Pins"] = "清除所有標記"
L["Clear"] = "Clear"
L["Click to Change Color"] = "點選以更換顏色"
L["Click to Load Set"] = "點選以讀取集合"
L["Close Tracker"] = "關閉追蹤器"
L["Confirm"] = "確認"
L["Create a Pin at Your Current Location"] = "在你現在的位置放置一個標記"
L["Create Set"] = "新的集合"
L["Delete Set"] = "刪除集合"
L["Disabled"] = "停用"
L["Displayed Number of Entries"] = "顯示條目數量"
L["Edit Set"] = "編輯集合"
L["Edit Set Name"] = "編輯集合名稱"
L["Editor Scale"] = "編輯器縮放"
L["Editor"] = "Editor"
L["Enable Unlimited Distance"] = "啟用無限距離"
L["Enter New Set Name"] = "輸入新集合名稱"
L["Export as Commands"] = "以指令輸出"
L["Export Set"] = "輸出集合"
L["Floating Pin"] = "Floating Pin"
L["General"] = "General"
L["Help"] = "Help"
L["Hide Minimap Button"] = "隱藏小地圖按鈕"
L["Icon"] = "圖示"
L["Import a Set"] = "匯入集合"
L["Import Pins from Map"] = "從地圖匯入標記"
L["Import Set"] = "匯入集合"
L["Import"] = "Import"
L["Imported Set"] = "匯入的集合"
L["Load Set"] = "讀取集合"
L["Lock Tracker"] = "鎖定追蹤器"
L["Map ID"] = "地圖編號"
L["Map Pin"] = "新標記"
L["Map Select"] = "Map Select"
L["Minimap Button Is Now Hidden"] = "小地圖按鈕現在已隱藏"
L["Minimap Button Is Now Visible"] = "小地圖按鈕現在已顯示"
L["Minimap"] = "Minimap"
L["My Way Back"] = "回去的路"
L["New Set"] = "新集合"
L["No Pins to Export."] = "沒有標記可以匯出."
L["Open Options"] = "開啟選項"
L["Options"] = "Options"
L["Override World Quest Tracking"] = "蓋過世界任務追蹤"
L["Paste a String to Import a Set"] = "貼上字串來匯入集合"
L["Persistent"] = "持續"
L["Pins"] = "標記"
L["Remove Pin"] = "移除標記"
L["Scale"] = "縮放"
L["Select a Set to Edit or Create a New One."] = "選擇一個集合來編輯或是創造新的集合."
L["Sets"] = "集合"
L["Share to Chat"] = "分享到聊天"
L["Shift-Click to Share to Chat"] = "Shift-點擊來分享到聊天"
L["Shift-Click to Load and Override All Pins"] = "Shift-點擊來讀取並蓋過所有標記"
L["Show Estimated Arrival Time"] = "顯示估計到達時間"
L["Show Numbering"] = "顯示編號"
L["Show on Map"] = "在地圖上顯示"
L["Show Options"] = "顯示選項"
L["Show Sets"] = "顯示集合"
L["Show This Help Message"] = "顯示此幫助訊息"
L["Show Title"] = "顯示標題"
L["The in-game navigation is disabled! Not all features of MapPinEnhanced will work properly. Do you want to enable it?"] =
"遊戲內導航已停用! 不是所有的 MapPinEnhanced 功能都能正常運作. 你想要啟用他嗎?"
L["Title"] = "標題"
L["Toggle Editor"] = "切換編輯器"
L["Toggle Minimap Button"] = "切換小地圖按鈕"
L["Toggle Persistent"] = "切換持續"
L["Toggle Tracker"] = "切換追蹤器"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"TomTom 已載入! 你可能會遇到一些非預期的行為."
L["Tracker"] = "Tracker"
L["View Pins"] = "檢視標記"
L["View Sets"] = "檢視集合"
L["When enabled, the floating pin will be shown even if the tracked pin is very far away."] =
"當啟用時, 即使追蹤的標記距離非常遠也會顯示成漂浮標記."
L["When enabled, the tracker will be shown/hidden automatically based on the number of active pins."] =
"當啟用時, 追蹤器會自動根據條目數量來 顯示/隱藏."
L["X"] = "X"
L["Y"] = "Y"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"你正在副本或無法使用地圖的區域"