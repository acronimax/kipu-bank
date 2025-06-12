![image](https://img.shields.io/badge/Solidity-e6e6e6?style=for-the-badge&logo=solidity&logoColor=black)
![image](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)

# KipuBank

Su tarea es recrear el smart contract KipuBank con funcionalidad completa y documentación como se describe a continuación.


#### Características de KipuBank:

- Los usuarios pueden depositar tokens nativos (ETH) en una bóveda personal
- Los usuarios pueden retirar fondos de su bóveda, pero solo hasta un umbral fijo por transacción, representado por una variable immutable
- El contrato enforce un límite global de depósito (bankCap), establecido durante el despliegue
- Las interacciones internas y externas deben seguir mejores prácticas de seguridad y declaraciones revert con errores personalizados claros si no se cumplen las condiciones
- Los eventos deben emitirse tanto en depósitos como en retiros exitosos
- El contrato debe llevar el registro del número de depósitos y retiros
- El contrato debe tener al menos una función external, una private, y una view

#### Prácticas de Seguridad a Seguir:

- Usar errores personalizados en lugar de strings de require
- Respetar el patrón checks-effects-interactions y convenciones de nomenclatura
- Usar modificadores donde sea apropiado para validar lógica
- Manejar transferencias nativas de forma segura
- Mantener variables de estado limpias, legibles y bien comentadas
- Agregar comentarios NatSpec para cada función, error y variable de estado
- Aplicar convenciones de nomenclatura apropiadas
