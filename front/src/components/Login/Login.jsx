import React from 'react'
import {FaUser, FaLock} from 'react-icons/fa';
import { useState } from 'react';
import { useNavigate, Link } from "react-router-dom";
import "./Login.css";
import App from '../../App';
const Login = () => {
  // a primeira le a segunda altera 
  const[email,setUsername] = useState("");
  const[senha, setPassword] = useState("");
  const [userId, setUserId] = useState(null);
  const [tokenUser, setTokenUser] = useState("")
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    const resp = await fetch("http://localhost:4000/api/auth/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, senha }),
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
            <button>Entrar</button>   

            <div style={{ marginTop: "18px", textAlign: "center" }}>
              <span>Não tem conta? </span>
              <Link to="/" style={{ color: "#fff", textDecoration: "underline", cursor: "pointer" }}>
                Clique Aqui.
              </Link>
            </div>

        </form>
        {localStorage.getItem("token") && (
          <div style={{
            background: "#222",
            color: "#fff",
            padding: "16px",
            borderRadius: "8px",
            marginTop: "24px",
            wordBreak: "break-all",
            fontFamily: "monospace",
            fontSize: "0.95em",
            boxShadow: "0 2px 8px rgba(0,0,0,0.15)"
          }}>
            <strong>Seu token JWT:</strong>
            <div style={{marginTop: "8px"}}>{localStorage.getItem("token")}</div>
          </div>
        )}
    </div>
  )
}

export default Login
