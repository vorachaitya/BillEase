import { useState } from "react";
import "../css/register.css";
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6aGxrY3dvbG5hZXJlb3dvZmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAwOTk2NzgsImV4cCI6MTk5NTY3NTY3OH0.LyyqZm5NOyK8oRkLqMpzggpEExpX5z-nyyDWgRsaAk4";
const supabase = createClient(supabaseUrl, supabaseKey);

const Register = () => {
  const [formUserData, setFormUserData] = useState({
    username: "",
    email: "",
    password: "",
  });
  const handleChange = (event) => {
    const newInput = (data) => ({
      ...data,
      [event.target.name]: event.target.value,
    });
    setFormUserData(newInput);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    const { data, error } = await supabase
      .from("user")
      .insert([
        {
          username: `${formUserData.username}`,
          email: `${formUserData.email}`,
          password: `${formUserData.password}`,
        },
      ]);

    const emptyInput = { username: "", email: "", password: "" };
    setFormUserData(emptyInput);
  };
  return (
    <>
      <div className="container-login">
        <div className="wrap-login">
          <form action="" method="">
            <span className="login-form-title">Register</span>

            <img
              className="avatar"
              src="https://cdn-icons-png.flaticon.com/512/3135/3135789.png"
              alt=""
              align="center"
            />

            <div className="wrap-input100">
              <input
                className="input100"
                type="text"
                onChange={handleChange}
                value={formUserData.username}
                name="username"
                placeholder="Username"
              />
              <span className="focus-efecto"></span>
            </div>

            <div className="wrap-input100">
              <input
                className="input100"
                type="text"
                onChange={handleChange}
                value={formUserData.email}
                name="email"
                placeholder="Email"
              />
              <span className="focus-efecto"></span>
            </div>
            <div className="wrap-input100">
              <input
                className="input100"
                type="text"
                onChange={handleChange}
                value={formUserData.password}
                name="password"
                placeholder="Password"
              />
              <span className="focus-efecto"></span>
            </div>

            <div className="container-login-form-btn">
              <div className="wrap-login-form-btn">
                <div className="login-form-bgbtn"></div>
                <button
                  name="btnEntrar"
                  type="submit"
                  onClick={handleSubmit}
                  className="login-form-btn"
                >
                  Register
                </button>
              </div>

              <p>
                Already registered ? <a href="/">Login</a>
              </p>
            </div>
          </form>
        </div>
      </div>
    </>
    // <>
    //   <div>
    //     <input
    //       type="text"
    //       onChange={handleChange}
    //       value={formUserData.username}
    //       name="username"
    //       className="form-control"
    //       placeholder="Username"
    //     />
    //   </div>
    //   <div className="col">
    //     <input
    //       type="text"
    //       onChange={handleChange}
    //       value={formUserData.email}
    //       name="email"
    //       className="form-control"
    //       placeholder="Email"
    //     />
    //   </div>
    //   <div className="col">
    //     <input
    //       type="text"
    //       onChange={handleChange}
    //       value={formUserData.password}
    //       name="password"
    //       className="form-control"
    //       placeholder="Password"
    //     />
    //     </div>
    //     <div className="col">
    //       <input
    //         type="submit"
    //         onClick={handleSubmit}
    //         className="btn btn-primary"
    //       />
    //     </div>

    // </>
  );
};

export default Register;
