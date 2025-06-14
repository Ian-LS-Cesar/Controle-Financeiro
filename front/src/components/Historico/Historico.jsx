import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Historico.css";

export default function Historico() {
  const token = localStorage.getItem("token");
  const userId = localStorage.getItem("userId");
  const [transacoes, setTransacoes] = useState([]);
  const [menuOpen, setMenuOpen] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    fetch(`http://localhost:4000/api/users/${userId}/transactions`, {
      headers: { "Authorization": "Bearer " + token }
    })
      .then(resp => resp.json())
      .then(data => setTransacoes(data.transactions || []));
  }, [token, userId]);

  return (
    <div className="historico-container">
      {/* Menu sanduíche */}
      <div style={{ width: "100%", display: "flex", justifyContent: "flex-end", position: "relative" }}>
        <button
          style={{
            background: "none",
            border: "none",
            fontSize: "2rem",
            cursor: "pointer",
            color: "#fff",
            marginBottom: "10px"
          }}
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Abrir menu"
        >
          &#9776;
        </button>
        {menuOpen && (
          <div
            style={{
              position: "absolute",
              right: 0,
              top: "calc(100% + 8px)",
              background: "#fff",
              color: "#4d6347",
              borderRadius: "8px",
              boxShadow: "0 2px 8px rgba(0,0,0,0.15)",
              zIndex: 10,
              minWidth: "140px"
            }}
          >
            <button
              style={{
                background: "none",
                border: "none",
                color: "#4d6347",
                padding: "12px 20px",
                width: "100%",
                textAlign: "left",
                cursor: "pointer",
                fontSize: "1rem"
              }}
              onClick={() => {
                setMenuOpen(false);
                navigate("/transacao");
              }}
            >
              Transação
            </button>
          </div>
        )}
      </div>
      <h2>Histórico de Transações</h2>
      <table className="historico-table">
        <thead>
          <tr>
            <th>Descrição</th>
            <th>Valor</th>
            <th>Tipo</th>
            <th>Data/Hora</th>
            <th>Categorias</th>
          </tr>
        </thead>
        <tbody>
          {transacoes.map(tx => (
            <tr key={tx.id}>
              <td>{tx.descricao}</td>
              <td>{tx.valor}</td>
              <td>{tx.tipo === 0 ? "Receita" : "Despesa"}</td>
              <td>{tx.data}</td>
              <td>{tx.tags?.map(tag => tag.nome).join(", ")}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}