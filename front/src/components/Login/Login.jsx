import React from 'react'
import {FaUser, FaLock} from 'react-icons/fa';
import { useState } from 'react';
import { useNavigate } from "react-router-dom";
import "./Login.css";
const Login = () => {
  // a primeira le a segunda altera 
  const[username,setUsername] = useState("");
  const[password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    const resp = await fetch("http://localhost:4000/api/auth/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email: username, password }),
    });
    if (resp.ok) {
      const data = await resp.json();
      
      localStorage.setItem("token", data.token);
      localStorage.setItem("userId", data.user.id);
      console.log("Login realizado, navegando para transacao");
      navigate("/transacao");
    } else {
      alert("Login inválido");
    }
  };

  return (
    <div className='container'>  
        <form onSubmit={handleSubmit}> 
            <h1> Login</h1>
            
            <div className='input-field'> 
              <input type="email" placeholder='Email'
              required
              onChange={(e) => setUsername(e.target.value)}/>
              <FaUser className= "icon"/>
            </div>

            <div className='input-field'> 
              <input type="password" placeholder='Senha'
              onChange={(e) => setPassword(e.target.value)}/>
              <FaLock className= "icon"/>
            </div>    

            {/* <div className='recall-forget'>
              <label>
                  <input type="checkbox"/>
                  lembre de mim
              </label>
              <a href="#">Esqueceu a senha?</a>
            </div> */}

            <button>Entrar</button>   

            {/*</Link */}

        </form>
    </div>
  )
}

export default Login
