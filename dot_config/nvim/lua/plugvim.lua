-- Download plug
local home = os.getenv ("HOME")
local filepath = home .. "/.local/share/nvim/site/autoload/plug.vim"
local file = io.open(filepath, "r")

if file == nil then
  io.popen("curl -s -fLo " .. filepath .. " --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'")
else
  io.close(file)
end
