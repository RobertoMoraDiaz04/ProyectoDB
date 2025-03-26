-- Tabla de Usuarios
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    contraseña VARCHAR(255) NOT NULL
);

-- Tabla de Categorías de productos
CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla de Productos
CREATE TABLE Producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) ON DELETE SET NULL
);

-- Tabla de Pedidos 
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Pendiente', 'Enviado', 'Entregado', 'Cancelado')) DEFAULT 'Pendiente',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- Tabla intermedia para Detalle del Pedido
CREATE TABLE DetallePedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE CASCADE
);

-- Tabla de Métodos de Pago
CREATE TABLE MetodoPago (
    id_metodo SERIAL PRIMARY KEY,
    tipo VARCHAR(20) CHECK (tipo IN ('Tarjeta', 'PayPal', 'Transferencia', 'Efectivo')) NOT NULL,
    detalles TEXT
);

-- Relación entre Pedido y Método de Pago 
CREATE TABLE PedidoPago (
    id_pedido INT PRIMARY KEY,
    id_metodo INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_metodo) REFERENCES MetodoPago(id_metodo) ON DELETE CASCADE
);

-- Tabla de Envíos 
CREATE TABLE Envio (
    id_envio SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    direccion_envio TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Preparando', 'En camino', 'Entregado')) DEFAULT 'Preparando',
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE
);
