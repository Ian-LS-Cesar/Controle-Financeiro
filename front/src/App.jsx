import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Cadastro from './components/cadastro/Cadastro';
import Login from './components/Login/Login';
import Transacao from './components/Transacao/Transacao';
import Historico from "./components/Historico/Historico";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Cadastro />} />
        <Route path="/login" element={<Login />} />
        <Route path="/transacao" element={<Transacao />} />
        <Route path="/historico" element={<Historico />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;