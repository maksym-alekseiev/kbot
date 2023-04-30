Description:
This bot can reply to your messages (case-insensitive): hi, hello, hello there, who are you, what is your version. 

Bot link:
t.me/maksymalekseiev_bot

Instructions:
1. Clone a GitHub repository and open it in your IDE.
2. Get a token. Visit https://t.me/botfather and start conversation. Use /newbot command to create a new bot. Reply with a name for your bot, for example "kbot". Then it will be necessary to reply with a username for your bot, it should end with "bot", for example use your firstname+lastname+_bot. It will reply with a link to your bot and a token.
3. Add token to your IDE environment in a secure way. Copy the token and run the following command "read -s TELE_TOKEN" in your IDE terminal. Click on right mouse button to paste the token value, hit enter OR CTRL+V to finish. Run the following command to verify the value of the TELE_TOKEN variable "echo $TELE_TOKEN". If it looks good, run the command "export TELE_TOKEN" so your bot can use it.
4. Build your bot running the command "go build -ldflags "-X="github.com/<your repo name>/kbot/cmd.appVersion=v<version number you want>
5. Run it using the command "./kbot start"
6. Open the conversation with your bot (use link you have got on step 2) and enjoy!

Examples:
1. If you send a message "Who are you", bot will reply with "I'm Kbot !"
2. If you send a message "What is your version", bot will reply with "My version is %version%"