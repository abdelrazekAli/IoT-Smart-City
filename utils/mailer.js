const nodemailer = require("nodemailer");
const { google } = require("googleapis");
const { OAuth2 } = google.auth;
const { EMAIL, clientId, clientSecret, refreshToken } = process.env;

const OAuth2_client = new OAuth2(clientId, clientSecret);
OAuth2_client.setCredentials({ refresh_token: refreshToken });

const mailer = async (otp, mailTo) => {
  const accessToken = OAuth2_client.getAccessToken();

  let transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      type: "OAuth2",
      user: EMAIL,
      clientId,
      clientSecret,
      refreshToken,
      accessToken,
    },
  });

  let mailOptions = {
    from: "Iot Smart City",
    to: mailTo,
    subject: "Iot Smart City Account Verification",
    html: `
    <h1 style="text-align: center;">Iot Smart City</h1>
    <div style="font-size: 18px;">
        <span style="margin-left:20%">Kindly use this code:</span> <b style="color: green;">${otp}</b>
    </div>
    <p style="margin: 1% 20%;">Thanks, <br>
        Smart City Team</p>`,
  };

  await transporter.sendMail(mailOptions);
};

module.exports = mailer;
