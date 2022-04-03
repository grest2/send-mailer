//
//  Injection.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            Logger.getInstance() as ILogger
        }
        
        register {
            MailManager() as IMailManager
        }
        
        register {
            CacheManager() as ICacheManager
        }
        
        register {
            CryptoManager() as ICryptoManager
        }
    }
}
